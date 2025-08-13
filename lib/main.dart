import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpert_test/controllers/home_screen_controller.dart';
import 'package:xpert_test/views/home_screen.dart';

/// Entry point of the application.
void main() {
  runApp(const MyApp());
}

/// Root widget configuring application theme and dependency injection.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  /// Builds a [MaterialApp] with dark theme and provides
  /// a [HomeScreenController] to the widget tree.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpert Test Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: ChangeNotifierProvider(
        create: (context) => HomeScreenController(),
        child: const HomeScreen(),
      ),
    );
  }
}
