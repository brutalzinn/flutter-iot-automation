import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//olha o acoplamento começando aqui
//jesus crysus
class DatabaseService extends GetxService {

late Database db;

  Future<DatabaseService> init() async {
    db = await _getDatabase();
    return this;
  }

  Database getDatabaseDb() => db;

  Future<Database> _getDatabase() async {
  
    var databasesPath = await getDatabasesPath();
    //--TESTE--
    // String path = join(databasesPath, 'iot_devices.db');
    // await deleteDatabase(path);
    //---

    return db = await openDatabase(join(databasesPath, 'iot_devices.db'), 
    onCreate: (db, version) async {
         await db.execute(
          '''CREATE TABLE dispositivo (id INTEGER PRIMARY KEY, room_id INTEGER, is_favorite INTEGER, tipo_id INTEGER, nome TEXT, descricao TEXT,
          mqtt_config TEXT, custom_data TEXT)''');
         await db.execute(
          '''CREATE TABLE ambiente (id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT)''');
      },
      version: 1,
    );
  }

}