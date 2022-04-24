import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/provider/dispositive_provider.dart';

class DispositiveRepository {

  final DispositiveProvider api;
  DispositiveRepository(this.api);

  getAll(int bedRoomId) {
    return api.getAll(bedRoomId);
  }

  save(Dispositive note) {
    return api.save(note);
  }

  update(Dispositive note) {
    return api.update(note);
  }

  delete(int id) {
    return api.delete(id);
  }
}