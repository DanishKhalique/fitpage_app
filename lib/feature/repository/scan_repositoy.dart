import 'package:travel_diary_flutter/feature/models/scan_model.dart';
import 'package:travel_diary_flutter/utils/api_client.dart';

class ScanRepository {
  final ApiClient apiClient;

  ScanRepository({required this.apiClient});

  Stream<List<Scan>> fetchScans() async* {
    final data = await apiClient.get('/data.json');
    yield (data as List).map((json) => Scan.fromJson(json)).toList();
  }
}
