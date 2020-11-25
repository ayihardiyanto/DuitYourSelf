// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';

import 'package:duit_yourself/domain/usecases/user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserUsecase userUsecase;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LocalStorage storage =
      LocalStorage(KeyLocalStorageConstants.userDetail);

  DashboardBloc({this.userUsecase});

  @override
  DashboardState get initialState => InitialDashboard();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is OpenProfile) {
      yield ProfileLoading();
      try {
        yield ProfileLoaded();
      } catch (_) {
        yield ProfileFailed();
      }
    }

    if (event is Home) {
      yield ToHome();
    }

    if (event is OnPostJobTapped) {
      yield ToPostJobScreen();
    }

    if (event is SaveProfile) {
      try {
        final username = event.username;
        final photo = event.profile;
        final desc = event.selfDescription;
        final headline = event.headline;
        final email = storage.getItem('email');
        var payload = {
          'name': username,
          'selfDescription': desc,
          'headline': headline,
        };
        var imageUri;
        if (photo != null) {
          print('PHOTO RUNTIME ${photo.runtimeType}');
          if (photo.runtimeType != File) {
            print('MASUK IF');
            print('PARAM $payload');
            await firestore.collection('user').doc(email).update(payload);
          } else {
            print('MASUK ELSE');
            print('PARAM $payload');

            print('PHOTO $photo');
            if (photo.runtimeType == File){
              print('MASUK SUB IF');
              fb.StorageReference _storage = fb
                  .storage()
                  .ref('duityourself/profilepicture/$email/$username.jpeg');

              print('STORAGE $_storage');
              fb.UploadTaskSnapshot uploadTaskSnapshot =
                  await _storage.put(photo).future;

              print('SNAPSHOT $uploadTaskSnapshot');

              imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
            }
            print('URL: $imageUri');
            final imagUriString = imageUri != null ? imageUri.toString() : '';
            payload['imageUrl'] = imagUriString;
            await firestore
                .collection('user')
                .doc(email)
                .update(payload)
                .then((value) => "SUCCESS")
                .catchError((e) => print('ERROR di catch $e'));
          }
        }
        yield ProfileSaved();
      } catch (e) {
        print('ERROR $e');
        yield ProfileFailed();
      }
    }
  }
}
