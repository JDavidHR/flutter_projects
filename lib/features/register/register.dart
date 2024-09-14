import 'package:flutter/material.dart';
import 'package:flutter_application/core/colors.dart';
import 'package:flutter_application/core/components/button_widget.dart';
import 'package:flutter_application/core/components/texfield_widget.dart';
import 'package:flutter_application/data/dbHelper/mongodb.dart';
import 'package:flutter_application/features/welcome/welcome.dart';
import 'package:flutter_application/model/entity/users.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// Controllers.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.surface,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width
              : 600,
          decoration: BoxDecoration(
            color: ThemeColors.onSurface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¡Únete a la Comunidad de Flutter Project!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Estamos encantados de tenerte aquí. Regístrate ahora y empieza a disfrutar de todas las ventajas exclusivas que ofrecemos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _buildContent(),
                ),
                const Text(
                  "No te lo pierdas, ¡registrarse es rápido y fácil! Solo presiona el botón de abajo y únete a nosotros en esta increíble aventura.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildContent() {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      runSpacing: 16,
      spacing: 16,
      children: [
        const Icon(
          Icons.account_circle_rounded,
          size: 120,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input de email
            TextfieldWidget(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.email_outlined),
              onValidator: (String? value) {
                return null; // No validator since we're handling it manually
              },
              onChanged: (String value) {},
            ),

            const SizedBox(height: 16),

            // Input de Password
            TextfieldWidget(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              hint: 'Password',
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.security_outlined),
              onValidator: (String? value) {
                return null;
              },
              onChanged: (String value) {},
            ),
          ],
        ),
      ],
    );
  }

  /// Botones de [cancelar] y [registrarse].
  _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Cancelar.
        ButtonWidget(
          text: 'Cancelar',
          icon: Icons.cancel_outlined,
          onPressed: () {
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
        const SizedBox(
          width: 16,
          height: 16,
        ),

        /// Registro.
        ButtonWidget(
          text: 'Registrarse',
          icon: Icons.person_add_outlined,
          onPressed: () {
            _register(
              _emailController.text,
              _passwordController.text,
            );
          },
          backgroundColor: ThemeColors.secondary,
          textColor: ThemeColors.onSecondary,
          iconColor: ThemeColors.onSecondary,
        ),
      ],
    );
  }

  /// Valida el correo electrónico.
  bool _validateEmail(String email) {
    if (email.isEmpty) {
      _showDialog("Error", "Por favor ingrese su correo electrónico");
      return false;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showDialog("Error", "Por favor ingrese un correo electrónico válido");
      return false;
    }
    return true;
  }

  /// Valida la contraseña.
  bool _validatePassword(String password) {
    if (password.isEmpty) {
      _showDialog("Error", "Por favor ingrese su contraseña");
      return false;
    }
    if (password.length < 6) {
      _showDialog("Error", "La contraseña debe tener al menos 6 caracteres");
      return false;
    }
    return true;
  }

  /// Función para registrar al usuario.
  Future<void> _register(String email, String password) async {
    if (!_validateEmail(email) || !_validatePassword(password)) {
      return;
    }

    // Verificar si el correo electrónico ya existe en la base de datos.
    bool emailExists = await MongoDatabase.valueExists('email', email);
    if (emailExists) {
      _showDialog("Error", "El correo electrónico ya está registrado");
      return;
    }

    /// Recolección de la información ingresada.
    final data = Users(
      id: M.ObjectId(),
      email: email,
      password: password,
    );

    /// Espera hasta que se inserte el usuario en la BD.
    await MongoDatabase.insertUser(data);

    /// Borrar información ingresada.
    _clearAll();

    /// Mensaje de finalización.
    _showDialog(
      "",
      "Usuario registrado con éxito",
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
        );
      },
    );
  }

  /// Borrar la información de los inputs.
  void _clearAll() {
    _emailController.text = "";
    _passwordController.text = "";
  }

  /// Dialogo.
  void _showDialog(String title, String content, [void Function()? onPressed]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
