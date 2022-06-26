
import 'package:application/app/core/infra/database/database_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/database/ambiente_model.dart';

class AmbienteService extends GetxService {

  late Database db;

 Future<AmbienteService> init() async {
    final dispositiveServices = Get.find<DatabaseService>();
    db = dispositiveServices.getDatabaseDb();
    return this;
  }

  Future<List<Ambiente>> getAll() async {
    final result = await db.rawQuery('SELECT * FROM ambiente ORDER BY id');
    print(result);
    return result.map((json) => Ambiente.fromJson(json)).toList();
  }

  Future<Ambiente> save(Ambiente note) async {
    final id = await db.rawInsert(
        'INSERT INTO ambiente (nome, descricao) VALUES (?,?)',
        [note.nome, note.descricao]);

    return note.copy(id: id);
  }

  Future<Ambiente> update(Ambiente note) async {
    final id = await db.rawUpdate(
        'UPDATE ambiente SET nome = ?, descricao = ? WHERE id = ?',
        [note.nome, note.descricao, note.id]);

    return note.copy(id: id);
  }

  Future<int> delete(int noteId) async {

    await db.rawDelete('DELETE FROM dispositivo WHERE room_id = ?', [noteId]);
    final id = await db.rawDelete('DELETE FROM ambiente WHERE id = ?', [noteId]);
    return id;
  }

  Future close() async {
    db.close();
  }
}