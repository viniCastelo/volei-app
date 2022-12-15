import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volei/pages/home_page.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Orientação da tela [Horizontal]:
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // Ocultar barras de status:
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
