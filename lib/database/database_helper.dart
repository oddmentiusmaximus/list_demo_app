import 'dart:async';
import 'dart:io' as io;
import 'package:countriesdemo/model/country_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  final String tableItem = "Country";
  final String columnId = "id";
  final String columnCountry = "country";
  final String columnRegion = "region";
  final String key = "key";

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "countries.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableItem ($columnId INTEGER PRIMARY KEY,$key TEXT,$columnCountry TEXT, $columnRegion TEXT)");
  }

  Future saveCountries(Country countryModel) async {
    var dbClient = await db;
    int res = await dbClient?.insert(tableItem, countryModel.toJson()) ?? 0;
    return res;
  }

  Future getCountries() async {
    var dbClient = await db;
    var result = await dbClient?.rawQuery("SELECT * FROM $tableItem");
    return result;
  }

  Future<int> deleteCountries(id) async {
    var dbClient = await db;
    return await dbClient
            ?.delete(tableItem, where: "$key = ?", whereArgs: [id]) ??
        0;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient?.close();
  }
}
