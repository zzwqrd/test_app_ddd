part of 'controller.dart';

sealed class SplashState {}

final class SplashStateInitial extends SplashState {}

enum Status { initial, start, success, failed }

class StateTest<T> extends Equatable {
  final Status status;
  final String? error;
  final T? data;

  const StateTest({
    required this.status,
    this.error,
    this.data,
  });

  StateTest<T> copyWith({
    Status? status,
    String? error,
    dynamic data,
  }) {
    return StateTest<T>(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, error, data];
}
