//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';
import 'package:flutter_application/core/components/button_widget.dart';
import 'package:flutter_application/core/components/preview_widget.dart';
import 'package:flutter_application/core/components/texfield_widget.dart';
import 'package:flutter_application/features/welcome/welcome.dart';
//import 'package:flutter_application/features/basic_components_app/basic_components_app.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with MaterialStateMixin {
  late bool isOk = false;
  late bool isOkPassword = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  initState() {
    super.initState();
    emailController;
    passController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.surface,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: 550,
          height: 500,
          decoration: BoxDecoration(
            color: ThemeColors.onSurface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Espacio
                const SizedBox(
                  height: 10,
                ),

                //Icono
                const PreviewWidget(
                  iconData: Icons.image,
                  iconColor: Colors.deepPurple,
                ),

                const SizedBox(
                  height: 20,
                ),

                //welcome back
                const Text(
                  "Bienvenido de vuelta, te extrañamos!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 179, 179, 179),
                    fontSize: 14,
                  ),
                ),

                //Espacio
                const SizedBox(
                  height: 20,
                ),

                //Input para email
                TextfieldWidget(
                  hint: "Email",
                  controller: emailController,
                  onValidator: (String? value) {
                    value = emailController.text;
                    if (value.isNotEmpty) {
                      setState(() {
                        isOk = true;
                      });
                    } else {
                      setState(() {
                        isOk = false;
                      });
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),

                //Espacio
                const SizedBox(
                  height: 10,
                ),

                //Input para el password
                TextfieldWidget(
                  hint: "Password",
                  controller: passController,
                  onValidator: (String? value) {
                    value = emailController.text;
                    if (value.isNotEmpty) {
                      setState(() {
                        isOkPassword = true;
                      });
                    } else {
                      setState(() {
                        isOkPassword = false;
                      });
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (String value) {},
                ),

                //Espacio
                const SizedBox(
                  height: 20,
                ),

                _buildActionButtons(),

                //Espacio
                const SizedBox(
                  height: 20,
                ),

                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No tienes una cuenta aún? Regístrate',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
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
          text: 'Entrar',
          icon: Icons.touch_app_outlined,
          onPressed: () {
            /* Redirigir a la página de registro
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );*/
          },
          backgroundColor: ThemeColors.secondary,
          textColor: ThemeColors.onSecondary,
          iconColor: ThemeColors.onSecondary,
        ),
        ButtonWidget(
          text: 'Volver',
          icon: Icons.arrow_back_rounded,
          onPressed: () {
            // Redirigir a la página de welcome
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
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
