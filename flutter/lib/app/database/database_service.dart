import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
          '''CREATE TABLE devices (id INTEGER PRIMARY KEY, room_id INTEGER, tipo_id INTEGER, nome TEXT, descricao TEXT,
           mqtt_host TEXT, mqtt_port INTEGER, mqtt_user TEXT, 
           mqtt_password TEXT, mqtt_id TEXT, mqtt_topic TEXT)''');
         await db.execute(
          '''CREATE TABLE bedrooms (id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT)''');
      },
      version: 1,
    );
  }

}