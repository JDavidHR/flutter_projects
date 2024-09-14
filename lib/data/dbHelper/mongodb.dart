import 'dart:developer';

import 'package:flutter_application/data/dbHelper/constant.dart';
import 'package:flutter_application/model/entity/users.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  /// Función para insertar datos en la base de datos.
  static Future<String> insertUser(Users data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Usuario creado";
      } else {
        return "ERROR: Se produjo un error al registrar el usuario";
      }
    } catch (e) {
      return ("ERROR: Se produjo un error al registrar el usuario: ${e.toString()}");
    }
  }

  /// Función genérica para verificar si un campo específico ya existe en
  /// la base de datos.
  static Future<bool> valueExists(String field, String value) async {
    try {
      var user = await userCollection.findOne(where.eq(field, value));
      return user != null;
    } catch (e) {
      return false;
    }
  }

  /// Obtiene a todos los usuarios de la BD.
  static Future<List<Map<String, dynamic>>> getUsersData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  /// Función para actualizar datos en la base de datos.
  static Future<String> updateUser(Users data) async {
    try {
      var result = await userCollection.findOne({"_id": data.id});
      if (result == null) {
        return "ERROR: Usuario no encontrado";
      }
      result['email'] = data.email;
      result['Password'] = data.password;
      await userCollection.save(result);
      return "Usuario actualizado correctamente";
    } catch (e) {
      return "ERROR: Se produjo un error al actualizar el usuario: ${e.toString()}";
    }
  }

  /// Función para autenticar un usuario con email y password.
  static Future<bool> authenticateUser(
    String email,
    String password,
  ) async {
    try {
      // Busca un usuario con el email dado.
      var user = await userCollection.findOne(where.eq('email', email));

      // Si no se encuentra el usuario, retorna falso.
      if (user == null) {
        return false;
      }

      // Verifica que la contraseña ingresada coincida.
      return user['password'] == password;
    } catch (e) {
      // Maneja errores si ocurren durante la autenticación.
      log("Error en autenticación: ${e.toString()}");
      return false;
    }
  }
}
