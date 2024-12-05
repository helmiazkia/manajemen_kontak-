import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ContactManagerApp());
}

class ContactManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Kontak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}