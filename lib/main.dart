import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tadek_niejadek/features/auht/pages/auth_gate.dart';
import 'package:tadek_niejadek/firebase_options.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tadek niejadek',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          FirebaseUILocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pl'),
          Locale('en'),
        ],
        home: const AuhtGate());
  }
}
