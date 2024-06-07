part of 'scanner_bloc.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanLoaded extends ScanState {
  final List<Scan> scans;

  const ScanLoaded(this.scans);

  @override
  List<Object> get props => [scans];
}

class ScanError extends ScanState {
  final String message;

  const ScanError(this.message);

  @override
  List<Object> get props => [message];
}
