import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';
import 'package:flutter_application/core/components/button_widget.dart';
import 'package:flutter_application/features/register/register.dart';

import 'package:flutter_application/features/test_files_mongo_db/show_and_update_data.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.surface,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: 600,
          decoration: BoxDecoration(
            color: ThemeColors.onSurface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  '¡Bienvenido a Flutter Project!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Estamos emocionados de que te unas a nuestra comunidad. Si ya tienes una cuenta, simplemente presiona "Iniciar Sesión" para acceder a todas nuestras funciones increíbles. Si aún no eres miembro, no te preocupes, ¡registrarse es rápido y fácil! Solo presiona el botón "Registrarse" y únete a nosotros en esta increíble aventura.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Botones de registro.
  Widget _buildActionButtons() {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      runSpacing: 16,
      spacing: 16,
      children: [
        ButtonWidget(
          text: 'Iniciar Sesión',
          icon: Icons.login_outlined,
          onPressed: () {},
          backgroundColor: ThemeColors.secondary,
          textColor: ThemeColors.onSecondary,
          iconColor: ThemeColors.onSecondary,
        ),
        ButtonWidget(
          text: 'Registrarse',
          icon: Icons.person_add_outlined,
          onPressed: () {
            // Redirigir a la página de registro
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          backgroundColor: ThemeColors.secondary,
          textColor: ThemeColors.onSecondary,
          iconColor: ThemeColors.onSecondary,
        ),
        ButtonWidget(
          text: 'Ver datos',
          icon: Icons.show_chart_outlined,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateData(),
              ),
            );
          },
          backgroundColor: ThemeColors.secondary,
          textColor: ThemeColors.onSecondary,
          iconColor: ThemeColors.onSecondary,
        ),
      ],
    );
  }
}
