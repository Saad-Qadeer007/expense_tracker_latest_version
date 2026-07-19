import 'package:expense_tracker_latest_version/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Expense_Provider.dart';
import 'Ultilities/App_Themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes().lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
