import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/database/bedroom_service.dart';
import 'package:get/get.dart';

class BedRoomProvider {
  
  final bedroomServices = Get.find<BedroomsService>();

  Future<List<Bedroom>> getAll() async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await bedroomServices.getAll();
  }

  Future<Bedroom> save(Bedroom note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await bedroomServices.save(note);
  }

  Future<Bedroom> update(Bedroom note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await bedroomServices.update(note);
  }

  Future<int> delete(int noteId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await bedroomServices.delete(noteId);
  }
}