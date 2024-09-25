import 'package:flutter/material.dart';

import './widgets/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundWallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF8FAB)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const Navigation(),
    );
  }
}
