import 'package:flutter/material.dart';
import 'package:flutter_application/core/components/card_widget.dart';
import 'package:flutter_application/core/components/texfield_widget.dart';
import 'package:flutter_application/data/dbHelper/mongodb.dart';

import 'package:flutter_application/model/entity/users.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  /// Lista de usuarios registrados en la BD.
  List<Users> users = [];

  /// Variable de estado para la carga de la interfaz.
  bool isLoading = true;

  /// Controllers.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Función para cargar los datos.
  Future<void> fetchData() async {
    try {
      var data = await MongoDatabase.getUsersData();
      setState(() {
        users = data.map((user) => Users.fromJson(user)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      debugPrint("Error al obtener los datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : users.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Update Data Users",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return displayCard(users[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: Text("No data available")),
      ),
    );
  }

  Widget displayCard(Users data) {
    return CustomCard(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data.email),
          IconButton(
            onPressed: () {
              _showDialog(data);
            },
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 3,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shadowColor: Colors.black54,
    );
  }

  void _showDialog(Users? data) {
    if (data != null) {
      _emailController.text = data.email;
      _passwordController.text = data.password;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Wrap(
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
          ),
          actions: [
            TextButton(
              onPressed: () {
                _update(
                  data!.id,
                  _emailController.text,
                  _passwordController.text,
                );
              },
              child: const Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }

  /// Valida el correo electrónico.
  bool _validateEmail(String email) {
    if (email.isEmpty) {
      _showDialogFromValidation(
          "Error", "Por favor ingrese su correo electrónico");
      return false;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showDialogFromValidation(
          "Error", "Por favor ingrese un correo electrónico válido");
      return false;
    }
    return true;
  }

  /// Valida la contraseña.
  bool _validatePassword(String password) {
    if (password.isEmpty) {
      _showDialogFromValidation("Error", "Por favor ingrese su contraseña");
      return false;
    }
    if (password.length < 6) {
      _showDialogFromValidation(
          "Error", "La contraseña debe tener al menos 6 caracteres");
      return false;
    }
    return true;
  }

  /// Función para registrar al usuario.
  Future<void> _update(M.ObjectId id, String email, String password) async {
    if (!_validateEmail(email) || !_validatePassword(password)) {
      return;
    }

    /// Recolección de la información ingresada.
    final updateData = Users(
      id: id,
      email: email,
      password: password,
    );

    /// Espera hasta que se actualice el usuario en la BD.
    var result = await MongoDatabase.updateUser(updateData);
    _showDialogFromValidation("", result);
  }

  /// Dialogo.
  void _showDialogFromValidation(String title, String content,
      [void Function()? onPressed]) {
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
