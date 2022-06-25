
import 'package:application/app/core/infra/database/dispositivo_service.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:get/get.dart';

class DispositivoProvider {
  final DispositivoServices = Get.find<DispositivoService>();

  Future<List<Dispositivo>> getAllDevicesById(int bedRoomId) async {
    // await Future.delayed(Duration(seconds: 2));
    return await DispositivoServices.getAllDevicesById(bedRoomId);
  }

  Future<List<Dispositivo>> getAllFavoriteDevices() async {
    // await Future.delayed(Duration(seconds: 2));
    return await DispositivoServices.getAllFavoriteDevices();
  }
  // Future<List<Dispositivo>> getAll() async {
  //   //descomente a linha abaixo para simular um tempo maior de resposta
  //   // await Future.delayed(Duration(seconds: 2));
  //   return await DispositivoServices.getAllByBedRoom(bedRoomId);
  // }

  Future<Dispositivo> save(Dispositivo device) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await DispositivoServices.save(device);
  }

  Future<Dispositivo> update(Dispositivo device) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await DispositivoServices.update(device);
  }

  Future<int> delete(int noteId) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await DispositivoServices.delete(noteId);
  }
}