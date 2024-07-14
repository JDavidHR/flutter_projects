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
}
