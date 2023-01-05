import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:volei/pages/home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Orientação da tela [Horizontal]:
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  // Ocultar barras de status:
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await GetStorage.init();
  runApp(
    ThemeProvider(
      themes: [
        AppTheme.dark(),
        AppTheme.light(),
      ],
      child: ThemeConsumer(
        child: Builder(builder: (context) {
          return GetMaterialApp(
            theme: ThemeProvider.themeOf(context).data,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        }),
      ),
    ),
  );
}
