import 'package:ai/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.reInitialize(apiKey: 'AIzaSyCZ34s1kYhjb-1FR7nArwjanuUV1xrYEJA',enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade200),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

