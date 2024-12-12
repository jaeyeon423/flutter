import 'package:notifier_provider/models/activity.dart';

sealed class SealedActivityState {
  const SealedActivityState();
}

final class SealedActivityStateInitial extends SealedActivityState {
  const SealedActivityStateInitial();

  @override
  String toString() => 'SealedActivityStateInitial';
}

final class SealedActivityStateLoading extends SealedActivityState {
  const SealedActivityStateLoading();

  @override
  String toString() => 'SealedActivityStateLoading';
}

final class SealedActivityStateSuccess extends SealedActivityState {
  final Activity activity;

  const SealedActivityStateSuccess({required this.activity});

  @override
  String toString() => 'SealedActivityStateSuccess';
}

final class SealedActivityStateFailure extends SealedActivityState {
  final String error;

  const SealedActivityStateFailure({required this.error});

  @override
  String toString() => 'SealedActivityStateFailure';
}
