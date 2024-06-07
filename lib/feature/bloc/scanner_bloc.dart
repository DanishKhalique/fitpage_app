import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_diary_flutter/feature/models/scan_model.dart';
import 'package:travel_diary_flutter/feature/repository/scan_repositoy.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanRepository repository;
  StreamSubscription<List<Scan>>? _scanSubscription;

  ScanBloc({required this.repository}) : super(ScanInitial()) {
    on<FetchScans>(_onFetchScans);
    on<ScansUpdated>(_onScansUpdated);
    on<ScansUpdateError>(_onScansUpdateError);
  }

  Future<void> _onFetchScans(FetchScans event, Emitter<ScanState> emit) async {
    emit(ScanLoading());
    await _scanSubscription?.cancel();
    _scanSubscription = repository.fetchScans().listen(
      (scans) {
        add(ScansUpdated(scans));
      },
      onError: (error) {
        add(ScansUpdateError(error.toString()));
      },
    );
  }

  void _onScansUpdated(ScansUpdated event, Emitter<ScanState> emit) {
    emit(ScanLoaded(event.scans));
  }

  void _onScansUpdateError(ScansUpdateError event, Emitter<ScanState> emit) {
    emit(ScanError(event.error));
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel();
    return super.close();
  }
}
