import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/database/database_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

//mudar nome dessa classe
class BedroomsService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

 Future<BedroomsService> init() async {
    final dispositiveServices = Get.find<DatabaseService>();
    db = dispositiveServices.getDatabaseDb();
    return this;
  }

  // recuperar todas as notas
  Future<List<Bedroom>> getAll() async {
    final result = await db.rawQuery('SELECT * FROM bedrooms ORDER BY id');
    print(result);
    return result.map((json) => Bedroom.fromJson(json)).toList();
  }

  //criar nova nota
  Future<Bedroom> save(Bedroom note) async {
    final id = await db.rawInsert(
        'INSERT INTO bedrooms (nome, descricao) VALUES (?,?)',
        [note.nome, note.descricao]);

    print(id);
    return note.copy(id: id);
  }

  //atualizar nota
  Future<Bedroom> update(Bedroom note) async {
    final id = await db.rawUpdate(
        'UPDATE bedrooms SET nome = ?, descricao = ? WHERE id = ?',
        [note.nome, note.descricao, note.id]);

    print(id);
    return note.copy(id: id);
  }

  Future<int> delete(int noteId) async {
    //não criei as relações ainda.
    await db.rawDelete('DELETE FROM devices WHERE room_id = ?', [noteId]);
    final id = await db.rawDelete('DELETE FROM bedrooms WHERE id = ?', [noteId]);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}