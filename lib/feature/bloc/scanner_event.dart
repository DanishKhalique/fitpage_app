part of 'scanner_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class FetchScans extends ScanEvent {}

class ScansUpdated extends ScanEvent {
  final List<Scan> scans;

  const ScansUpdated(this.scans);

  @override
  List<Object> get props => [scans];
}

class ScansUpdateError extends ScanEvent {
  final String error;

  const ScansUpdateError(this.error);

  @override
  List<Object> get props => [error];
}
