
import 'package:application/app/core/infra/database/dispositivo_service.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:get/get.dart';

class DispositivoProvider {
  final dispositivoService = Get.find<DispositivoService>();

  Future<Dispositivo> get(int dispositivoId) async {
    // await Future.delayed(Duration(seconds: 2));
    return await dispositivoService.get(dispositivoId);
  }

  Future<List<Dispositivo>> getAllDevicesByAmbiente(int ambienteId) async {
    // await Future.delayed(Duration(seconds: 2));
    return await dispositivoService.getAllDevicesByAmbiente(ambienteId);
  }

  Future<List<Dispositivo>> getAllFavoriteDevices() async {
    // await Future.delayed(Duration(seconds: 2));
    return await dispositivoService.getAllFavoriteDevices();
  }
  // Future<List<Dispositivo>> getAll() async {
  //   //descomente a linha abaixo para simular um tempo maior de resposta
  //   // await Future.delayed(Duration(seconds: 2));
  //   return await dispositivoService.getAllByBedRoom(bedRoomId);
  // }

  Future<Dispositivo> save(Dispositivo device) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositivoService.save(device);
  }

  Future<Dispositivo> update(Dispositivo device) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositivoService.update(device);
  }

  Future<bool> executeQuery(String sql, List<Object>? args) async{
     return await dispositivoService.executeQuery(sql, args);
  }

  Future<List<Dispositivo>> executeQueryList(String sql, List<Object>? args) async {
    return await dispositivoService.executeQueryList(sql, args);
  }

  Future<int> delete(int noteId) async {
    //await Future.delayed(const Duration(seconds: 2));
    return await dispositivoService.delete(noteId);
  }
}