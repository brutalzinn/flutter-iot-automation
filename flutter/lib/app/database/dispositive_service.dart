import 'package:application/app/data/model/dispositive_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//mudar nome dessa classe
class DispositiveService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

  Future<DispositiveService> init() async {
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
        return db.execute('''CREATE TABLE dispositives (id INTEGER PRIMARY KEY, bedRoomId INTEGER, nome TEXT,
            descricao TEXT, mqtthost TEXT, mqttport INTEGER, mqttuser TEXT,
            mqttpassword TEXT, mqttid TEXT, mqtttopic TEXT)''');
      },
      version: 1,
    );
  }

  // recuperar todas as notas
  Future<List<Dispositive>> getAllByBedRoom(int bedRoomId) async {
    final result = await db.rawQuery('SELECT * FROM dispositives WHERE bedRoomId=? ORDER BY id',[bedRoomId]);
    print(result);
    return result.map((json) => Dispositive.fromJson(json)).toList();
  }

  // Future<List<Dispositive>> getById(int device) async {
  //   final result = await db.rawQuery('SELECT * FROM dispositives WHERE id=?',[device]);
  //   print(result);
  //   return result.map((json) => Dispositive.fromJson(json)).toList();
  // }

  //criar nova nota
  Future<Dispositive> save(Dispositive note) async {
    final id = await db.rawInsert(
        'INSERT INTO dispositives (nome, descricao) VALUES (?,?)',
        [note.nome, note.descricao]);

    print(id);
    return note.copy(id: id);
  }

  //atualizar nota
  Future<Dispositive> update(Dispositive note) async {
    final id = await db.rawUpdate(
        'UPDATE dispositives SET nome = ?, descricao = ? WHERE id = ?',
        [note.nome, note.descricao, note.id]);

    print(id);
    return note.copy(id: id);
  }

  //excluir nota
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM dispositives WHERE id = ?', [noteId]);

    print(id);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}