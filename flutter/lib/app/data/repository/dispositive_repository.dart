import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/provider/dispositive_provider.dart';

class DispositiveRepository {

  final DispositiveProvider api;
  
  DispositiveRepository(this.api);

  getAll(int bedRoomId) {
    return api.getAllByBedRoom(bedRoomId);
  }

  save(Dispositive device) {
    return api.save(device);
  }

  update(Dispositive device) {
    return api.update(device);
  }

  delete(int id) {
    return api.delete(id);
  }
}