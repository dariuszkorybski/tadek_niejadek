import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tadek_niejadek/features/pages/auth_gate.dart';
import 'package:tadek_niejadek/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Tadek niejadek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
