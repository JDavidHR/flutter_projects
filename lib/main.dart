import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/counter/counter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración específica para plataformas de escritorio
  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    // Establecer tamaño mínimo de la ventana
    await DesktopWindow.setMinWindowSize(const Size(360, 640));

    // Establecer tamaño predeterminado de la ventana
    await DesktopWindow.setWindowSize(const Size(1440, 820));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Otros ajustes de tema según sea necesario
      ),
      home: const Counter(title: 'Flutter Demo Home Page'),
    );
  }
}
