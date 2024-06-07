// import 'package:travel_diary_flutter/feature/bloc/scan_bloc.dart';
// import 'package:travel_diary_flutter/feature/bloc/scan_event.dart';
// import 'package:travel_diary_flutter/feature/bloc/scan_state.dart';

// void main() {
//   group('ScanBloc', () {
//     late ScanRepository scanRepository;
//     late ScanBloc scanBloc;

//     setUp(() {
//       scanRepository = MockScanRepository();
//       scanBloc = ScanBloc(scanRepository: scanRepository);
//     });

//     blocTest<ScanBloc, ScanState>(
//       'emits [ScanLoading, ScanLoaded] when FetchScans is added',
//       build: () {
//         when(scanRepository.fetchScans()).thenAnswer((_) async => [MockScan()]);
//         return scanBloc;
//       },
//       act: (bloc) => bloc.add(FetchScans()),
//       expect: () => [
//         ScanLoading(),
//         ScanLoaded([MockScan()])
//       ],
//     );

//     blocTest<ScanBloc, ScanState>(
//       'emits [ScanLoading, ScanError] when FetchScans fails',
//       build: () {
//         when(scanRepository.fetchScans())
//             .thenThrow(Exception('Error fetching scans'));
//         return scanBloc;
//       },
//       act: (bloc) => bloc.add(FetchScans()),
//       expect: () =>
//           [ScanLoading(), ScanError('Exception: Error fetching scans')],
//     );
//   });
// }
