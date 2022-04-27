import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/database/dispositive_service.dart';
import 'package:get/get.dart';

class DispositiveProvider {
  final dispositiveServices = Get.find<DispositiveService>();

  Future<List<Dispositive>> getAllByBedRoom(int bedRoomId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await dispositiveServices.getAllByBedRoom(bedRoomId);
  }

  // Future<List<Dispositive>> getAll() async {
  //   //descomente a linha abaixo para simular um tempo maior de resposta
  //   // await Future.delayed(Duration(seconds: 2));
  //   return await dispositiveServices.getAllByBedRoom(bedRoomId);
  // }

  Future<Dispositive> save(Dispositive device) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositiveServices.save(device);
  }

  Future<Dispositive> update(Dispositive device) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositiveServices.update(device);
  }

  Future<int> delete(int noteId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositiveServices.delete(noteId);
  }
}