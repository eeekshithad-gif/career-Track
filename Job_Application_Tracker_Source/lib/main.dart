import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/job_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => JobProvider()..load(),
    child: const JobTrackerApp(),
  ));
}

class JobTrackerApp extends StatelessWidget {
  const JobTrackerApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'CareerTrack',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B61)),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F7F7),
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    ),
    home: const HomeScreen(),
  );
}
