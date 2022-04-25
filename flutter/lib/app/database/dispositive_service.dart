import 'package:application/app/data/model/dispositive_model.dart';
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

  // recuperar todas as notas
  Future<List<Dispositive>> getAllByBedRoom(int bedRoomId) async {
    final result = await db.rawQuery('SELECT * FROM devices WHERE room_id = ? ORDER BY id',[bedRoomId]);
    print("tentando obter com id do comodo ${bedRoomId}");
    print(result);
    return result.map((json) => Dispositive.fromJson(json)).toList();
  }

  //criar nova nota
  Future<Dispositive> save(Dispositive device) async {
    final id = await db.rawInsert(
        'INSERT INTO devices (room_id, nome, descricao, mqtt_host, mqtt_port, mqtt_user, mqtt_password, mqtt_id, mqtt_topic) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [device.roomId, device.nome, device.descricao, device.mqttConfig.mQTTHost, device.mqttConfig.mQTTPORT, device.mqttConfig.mQTTUSER, device.mqttConfig.mQTTPASSWORD, device.mqttConfig.mQTTID, device.mqttConfig.mqTTtopic]);

    print(id);
    return device.copy(id: id);
  }

  //atualizar nota
  Future<Dispositive> update(Dispositive device) async {
    final id = await db.rawUpdate(
        'UPDATE devices SET nome = ?, descricao = ?, room_id = ? WHERE id = ?',
        [device.nome, device.descricao, device.roomId, device.id]);

    print(id);
    return device.copy(id: id);
  }

  //excluir nota
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM devices WHERE id = ?', [noteId]);

    print(id);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}