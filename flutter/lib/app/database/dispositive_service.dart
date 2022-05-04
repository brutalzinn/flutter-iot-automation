import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/database/database_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

//mudar nome dessa classe
class DispositiveService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

  Future<DispositiveService> init() async {
    final dispositiveServices = Get.find<DatabaseService>();
    db = dispositiveServices.getDatabaseDb();
    return this;
  }

  // recuperar todos os dispositivos
  Future<List<Dispositive>> getAllDevicesById(int deviceId) async {
    final result = await db.rawQuery('SELECT * FROM devices WHERE room_id = ? ORDER BY id',[deviceId]);
    print("tentando obter dispositive com ambiente de id: ${deviceId}");
    return result.map((json) => Dispositive.fromJson(json)).toList();
  }
  // recuperar dispositivos favoritos
    Future<List<Dispositive>> getAllFavoriteDevices() async {
    final result = await db.rawQuery('SELECT * FROM devices WHERE is_favorite = ? ORDER BY id', [1]);
    print("tentando obter dispositivos favoritos");

    return result.map((json) => Dispositive.fromJson(json)).toList();
  }

  //criar novo dispositivo
  Future<Dispositive> save(Dispositive device) async {
    final id = await db.rawInsert(
        'INSERT INTO devices (room_id, is_favorite, tipo_id, nome, descricao, mqtt_host, mqtt_port, mqtt_user, mqtt_password, mqtt_id, mqtt_topic) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [device.roomId, device.isFavorite, device.tipoId, device.nome, device.descricao, device.mqttConfig.mQTTHost, device.mqttConfig.mQTTPORT, device.mqttConfig.mQTTUSER, device.mqttConfig.mQTTPASSWORD, device.mqttConfig.mQTTID, device.mqttConfig.mqTTtopic]);
    
    print(id);
    return device.copy(id: id);
  }

  //atualizar dispositivo
  Future<Dispositive> update(Dispositive device) async {
    final id = await db.rawUpdate(
        'UPDATE devices SET is_favorite = ?, tipo_id = ?, nome = ?, descricao = ?, room_id = ? WHERE id = ?',
        [device.isFavorite, device.tipoId, device.nome, device.descricao, device.roomId, device.id]);
    print(id);
    return device.copy(id: id);
  }

  //excluir device
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM devices WHERE id = ?', [noteId]);
    return id;
  }

  Future close() async {
    db.close();
  }
}