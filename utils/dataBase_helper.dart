import 'dart:io';

import 'package:bees_pharmacy/model/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = '_id';
  static final columnName = 'Name';

  static final columnImage = 'image';
  static final columnPrice = 'price';
  static final columnProductId = 'productId';
  static final columnVariant = 'variant';
  static final columnVariantType = 'variantType';
  static final columnQuantity = 'quantity';

//making it a singleton class
  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)
  Future _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $_tableName (
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnImage TEXT,
    $columnPrice DOUBLE,
    $columnProductId INTEGER,
    $columnVariant INTEGER,
    $columnVariantType TEXT,
    $columnQuantity INTEGER
    )
   ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    int productId = row[columnProductId];
    int variantId = row[columnVariant];
    print("variantId $variantId");
    print("productId  $productId ");
    Database db = await instance.database;

    List<Map> variantData = await db
        .query(_tableName, where: '$columnVariant = ?', whereArgs: [variantId]);
    print(variantData);

    if (variantData.length == 0) {
      print("different product");
      return await db.insert(_tableName, row);
    } else {
      print("same product");
      return variantData[0]['_id'];
    }
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, int variantId) async {
    Database db = await instance.database;

    List<Map> data = await db
        .query(_tableName, where: '$columnProductId = ?', whereArgs: [id]);
    print(data);
    if (variantId == null) {
      return await db
          .delete(_tableName, where: '$columnProductId = ?', whereArgs: [id]);
    } else if (data.length != 0 && variantId != null) {
      for (int i = 0; i < data.length; i++) {
        if (variantId == data[i]["variant"]) {
          print("same product");
          await db.delete(_tableName,
              where: '$columnVariant = ?', whereArgs: [variantId]);
          return 2;
        }
      }
    } else
      return 0;

    return await db
        .delete(_tableName, where: '$columnProductId = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    Database db = await instance.database;
    return await db.execute('DELETE FROM $_tableName');
  }

  Future<List<CartModel>> getCart() async {
    Database db = await instance.database;

    List<Map> maps = await db.query(
      _tableName,
      columns: [
        columnId,
        columnName,
        columnImage,
        columnPrice,
        columnProductId,
        columnVariant,
        columnVariantType,
        columnQuantity,
      ],
    );

    if (maps.length > 0) {
      List<CartModel> cartModel = [];

      for (int i = 0; i < maps.length; i++) {
        cartModel.add(CartModel.fromMap(maps[i]));
      }

      return cartModel;
    }
    return [];
  }
}
