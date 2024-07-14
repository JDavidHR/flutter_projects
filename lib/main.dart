import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';
import 'package:flutter_application/data/dbHelper/mongodb.dart';
import 'package:flutter_application/features/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Espera hasta que se conecte con la base de datos.
  await MongoDatabase.connect();

  // Configuración específica para plataformas de escritorio
  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    // Establecer tamaño mínimo de la ventana
    await DesktopWindow.setMinWindowSize(const Size(360, 640));

    // Establecer tamaño predeterminado de la ventana
    await DesktopWindow.setWindowSize(const Size(1440, 820));
  }

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      color: Colors.white,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const Scaffold(
        backgroundColor: ThemeColors.surface,
        body: SafeArea(
          child: WelcomePage(),
        ),
      ),
    ),
  );
}
