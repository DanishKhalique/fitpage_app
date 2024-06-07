import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diary_flutter/feature/bloc/scanner_bloc.dart';
import 'package:travel_diary_flutter/feature/repository/scan_repositoy.dart';
import 'package:travel_diary_flutter/feature/ui/scan_screen.dart';
import 'package:travel_diary_flutter/utils/api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create the ScanRepository once and pass it down the widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPage',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 16)),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 14),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          Provider(
              create: (_) => ApiClient(
                  baseUrl: 'http://coding-assignment.bombayrunning.com')),
          ProxyProvider<ApiClient, ScanRepository>(
            update: (_, apiClient, __) => ScanRepository(apiClient: apiClient),
          ),
          ProxyProvider<ScanRepository, ScanBloc>(
            update: (_, repository, __) => ScanBloc(repository: repository),
          ),
        ],
        child: const ScanScreen(),
      ),
    );
  }
}
