

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

    if (event is SaveProfile) {
      try {
        final username = event.username;
        final photo = event.profile;
        final desc = event.selfDescription;
        final headline = event.headline;
        final email = storage.getItem('email');
        var imageUri;
        if (photo != null) {
          if (photo.runtimeType == Image) {
            await firestore.collection('user').doc(email).update({
              'name': username,
              'profile image': '',
              'selfDescription': desc,
              'headline': headline,
            });
          } else {
            fb.StorageReference _storage = fb
                .storage()
                .ref('duityourself/profilepicture/$email/$username.jpeg');
            fb.UploadTaskSnapshot uploadTaskSnapshot =
                await _storage.put(photo).future;

            imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
            print('URL: $imageUri');
            final imagUriString = imageUri != null ? imageUri.toString() : '';
            await firestore.collection('user').doc(email).update({
              'name': username,
              'profile image': '',
              'selfDescription': desc,
              'headline': headline,
              'imageUrl': imagUriString
            });
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
