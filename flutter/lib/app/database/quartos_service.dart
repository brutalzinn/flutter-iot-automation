import 'package:application/app/data/model/quarto_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//mudar nome dessa classe
class BedroomsService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

  Future<BedroomsService> init() async {
    db = await _getDatabase();
    //criar nota de teste
    // final note = Note(
    //   title: 't1',
    //   content: 'c1',
    // );
    // await save(note);
    // await getAll();
    return this;
  }

  Future<Database> _getDatabase() async {
    // Recupera pasta da aplicacao
    var databasesPath = await getDatabasesPath();
    // Recupera caminho da database e excluir database
    // String path = join(databasesPath, 'notes.db');
    // descomente o await abaixo para excluir a base de dados do caminho
    // recuperado pelo path na inicializacao
    // await deleteDatabase(path);
    // Retorna o banco de dados aberto
    return db = await openDatabase(
      join(databasesPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE bedrooms (id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT)');
      },
      version: 1,
    );
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

  //excluir nota
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM bedrooms WHERE id = ?', [noteId]);

    print(id);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}