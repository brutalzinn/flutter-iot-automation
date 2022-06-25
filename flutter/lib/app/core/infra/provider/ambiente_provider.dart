
import 'package:application/app/core/infra/database/ambiente_service.dart';
import 'package:application/app/model/database/ambiente_model.dart';
import 'package:get/get.dart';

class AmbienteProvider {
  
  final ambienteService = Get.find<AmbienteService>();

  Future<List<Ambiente>> getAll() async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await ambienteService.getAll();
  }

  Future<Ambiente> save(Ambiente note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await ambienteService.save(note);
  }

  Future<Ambiente> update(Ambiente note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await ambienteService.update(note);
  }

  Future<int> delete(int noteId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await ambienteService.delete(noteId);
  }
}