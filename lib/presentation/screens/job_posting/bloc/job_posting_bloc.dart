// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duit_yourself/common/constants/date_format_constants.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';

import 'package:duit_yourself/domain/usecases/user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
part 'job_posting_event.dart';
part 'job_posting_state.dart';

@injectable
class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  final UserUsecase userUsecase;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LocalStorage storage =
      LocalStorage(KeyLocalStorageConstants.userDetail);

  JobPostBloc({this.userUsecase});

  @override
  JobPostState get initialState => InitialJobPost();

  @override
  Stream<JobPostState> mapEventToState(
    JobPostEvent event,
  ) async* {
    if (event is OpenJob) {
      yield JobPostLoading();

      try {
        final jobId = event.jobId;
        final result =
            await firestore.collection('posted-job').doc(jobId).get();

        if (result != null) {
          yield JobPostLoaded();
        } else {
          yield JobPostFailed();
        }
      } catch (_) {
        yield JobPostFailed();
      }
    }

    if (event is SaveJob) {
      try {
        final jobId = event.jobId;
        final jobTitle = event.jobTitle;
        final image = event.image;
        final desc = event.description;
        final req = event.requirement;
        final email = storage.getItem('email');
        var payload = {
          'jobTitle': jobTitle,
          'description': desc,
          'requirements': req.split(';'),
          'postedDate': DateFormatConstants.ddMMyyyyDash.format(DateTime.now()),
          'status': event.status,
          'jobPoster': email,
        };
        var imageUri;
        if (image != null) {
          print('PHOTO RUNTIME ${image.runtimeType}');
          if (image.runtimeType != File) {
            print('MASUK IF JOB');
            if (jobId == null) {
              await firestore
                  .collection('posted-job')
                  .add(payload)
                  .then((value) => "SUCCESS")
                  .catchError((e) => print('ERROR di catch $e'));
            } else {
              await firestore
                  .collection('posted-job')
                  .doc(jobId)
                  .update(payload)
                  .then((value) => "SUCCESS")
                  .catchError((e) => print('ERROR di catch $e'));
            }
          } else {
            print('MASUK ELSE JOB');
            if (image.runtimeType == File) {
              print('MASUK SUB IF JOB');
              fb.StorageReference _storage =
                  fb.storage().ref('duityourself/jobs/$email/$jobTitle.jpeg');

              print('STORAGE $_storage');
              fb.UploadTaskSnapshot uploadTaskSnapshot =
                  await _storage.put(image).future;

              print('SNAPSHOT $uploadTaskSnapshot');

              imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
            }
            print('URL: $imageUri');
            final imagUriString = imageUri != null ? imageUri.toString() : '';
            payload['imageUrl'] = imagUriString;
            if (jobId == null) {
              print('MASUK SAVE');
              await firestore
                  .collection('posted-job')
                  .add(payload)
                  .then((value) => "SUCCESS")
                  .catchError((e) => print('ERROR di catch $e'));

              print('SUKSES SAVE');
            } else {
              print('MASUK UPDATE');
              await firestore
                  .collection('posted-job')
                  .doc(jobId)
                  .update(payload)
                  .then((value) => "SUCCESS")
                  .catchError((e) => print('ERROR di catch $e'));
            }
          }
        } else {
          payload['imageUrl'] = '';
          if (jobId == null) {
            await firestore
                .collection('posted-job')
                .add(payload)
                .then((value) => "SUCCESS")
                .catchError((e) => print('ERROR di catch $e'));
          } else {
            await firestore
                .collection('posted-job')
                .doc(jobId)
                .update(payload)
                .then((value) => "SUCCESS")
                .catchError((e) => print('ERROR di catch $e'));
          }
        }
        yield JobPostSaved();
      } catch (e) {
        print('ERROR $e');
        yield JobPostFailed();
      }
    }
  }
}
