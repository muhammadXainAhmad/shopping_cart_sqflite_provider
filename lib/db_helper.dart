import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _myDb;

  Future<Database?> getDb() async {
    if (_myDb != null) {
      return _myDb!;
    } else {
      _myDb = await openDb();
      return _myDb!;
    }
  }

  Future<Database> openDb() async {
    Directory appDir = await getApplicationCacheDirectory();
    String dbPath = join(appDir.path, "cartDb.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )',
        );
      },
    );
  }

  Future<Cart> insertItem(Cart cart) async {
    var dbClient = await getDb();
    await dbClient!.insert("cart", cart.toMap());
    return cart;
  }
}
