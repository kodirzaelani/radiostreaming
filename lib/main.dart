import 'package:flutter/material.dart';
import 'package:radiosdk26/pages/radio_stream.dart';
import 'package:radiosdk26/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaming Radio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/stream-radio': (context) => const StreamRadioPage(),
      },
    );
  }
}
