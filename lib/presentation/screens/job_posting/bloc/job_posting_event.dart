part of 'job_posting_bloc.dart';

abstract class JobPostEvent extends Equatable {
  const JobPostEvent();
}

class OpenJob extends JobPostEvent {
  final String jobId;

  OpenJob({
    this.jobId,
  });
  @override
  String toString() => 'OpenJob';

  @override
  List<Object> get props => [];
}


class SaveJob extends JobPostEvent {
  final String jobId;
  final String jobTitle;
  final String description;
  final String budget;
  final dynamic image;
  final String requirement;
  final String status;
  SaveJob({
    this.jobTitle,
    this.description,
    this.image,
    this.requirement,
    this.jobId,
    this.budget,
    this.status,
  });
  @override
  String toString() => 'SaveJob';

  @override
  List<Object> get props => [
        jobTitle,
        description,
        image,
        requirement,
        jobId,
        budget,
        status,
      ];
}
