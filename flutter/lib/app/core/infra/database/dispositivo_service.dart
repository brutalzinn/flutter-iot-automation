
import 'package:application/app/core/infra/database/database_service.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

//mudar nome dessa classe
class DispositivoService extends GetxService {

  late Database db;

  Future<DispositivoService> init() async {
    final dispositivoService = Get.find<DatabaseService>();
    db = dispositivoService.getDatabaseDb();
    return this;
  }

  Future<Dispositivo> get(int dispositivoId) async {
    final result = await db.rawQuery('SELECT * FROM dispositivo WHERE id = ?',[dispositivoId]) as dynamic;
    return Dispositivo.fromJson(result);
  }

  // recuperar todos os dispositivos
  Future<List<Dispositivo>> getAllDevicesById(int deviceId) async {
    final result = await db.rawQuery('SELECT * FROM dispositivo WHERE room_id = ? ORDER BY id', [deviceId]);
    print("tentando obter dispositivo com ambiente de id: $deviceId");
    return result.map((json) => Dispositivo.fromJson(json)).toList();
  }
  // recuperar dispositivos favoritos
    Future<List<Dispositivo>> getAllFavoriteDevices() async {
    final result = await db.rawQuery('SELECT * FROM dispositivo WHERE is_favorite = ? ORDER BY id', [1]);
    print("tentando obter dispositivo favoritos");

    return result.map((json) => Dispositivo.fromJson(json)).toList();
  }

  //criar novo dispositivo
  Future<Dispositivo> save(Dispositivo device) async {
    final id = await db.rawInsert(
        'INSERT INTO dispositivo (room_id, is_favorite, tipo_id, nome, descricao, mqtt_config, custom_data) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [device.roomId, device.isFavorite, device.tipoId, device.nome, device.descricao, device.mqttConfig?.mqttToJson(), customDataListToJson(device.customData ?? [])]);
    
    print(id);
    return device.copy(id: id);
  }

  //atualizar dispositivo
  Future<Dispositivo> update(Dispositivo device) async {
    final id = await db.rawUpdate(
        'UPDATE dispositivo SET is_favorite = ?, tipo_id = ?, nome = ?, descricao = ?, room_id = ?, mqtt_config = ?, custom_data = ? WHERE id = ?',
        [device.isFavorite, device.tipoId, device.nome, device.descricao, device.roomId, device.mqttConfig?.mqttToJson(), customDataListToJson(device.customData ?? []) , device.id]);
    print(id);
    return device.copy(id: id);
  }

  Future<bool> executeQuery(String sql, List<Object>? args) async {
    await db.execute(sql, args);
    return true;
  }

  Future<List<Dispositivo>> executeQueryList(String sql, List<Object>? args) async {
    final result = await db.rawQuery(sql, args);
    return result.map((json) => Dispositivo.fromJson(json)).toList();
  }
  //excluir device
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM dispositivo WHERE id = ?', [noteId]);
    return id;
  }

  Future close() async {
    db.close();
  }
}