// lib/main.dart
import 'package:flutter/material.dart';
import 'package:medical/provider/theme_provider.dart';
import 'package:medical/repository/bookmark_repository.dart';
import 'package:medical/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider(create: (_) => BookmarkRepository(prefs)),
        // Add other providers
      ],
      child: const NexusMedicalApp(),
    ),
  );
}

class NexusMedicalApp extends StatelessWidget {
  const NexusMedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Nexus Medical AI',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade800,
          secondary: Colors.blueAccent.shade700,
        ),
        // Add light theme customizations
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue.shade300,
          secondary: Colors.blueAccent.shade200,
          surface: Colors.grey.shade900,
        ),
        // Add dark theme customizations
      ),
      themeMode: themeProvider.themeMode,
      home: const HomeScreen(),
    );
  }
}

// 4 milestone Achieve
