part of 'job_posting_bloc.dart';

@immutable
abstract class JobPostState extends Equatable {
  const JobPostState();

  @override
  List<Object> get props => [];
}

class JobPostLoaded extends JobPostState {
  @override
  String toString() => '';
}

class InitialJobPost extends JobPostState {}

class JobPostLoading extends JobPostState {}

class JobPostFailed extends JobPostState {}

class JobPostSaved extends JobPostState {}
class SavingJobPost extends JobPostState {}


