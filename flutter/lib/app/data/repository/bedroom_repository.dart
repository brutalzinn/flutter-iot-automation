import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/data/provider/bedroom_provider.dart';

class BedRoomRepository {

  final BedRoomProvider api;
  
  BedRoomRepository(this.api);

  getAll() {
    return api.getAll();
  }

  save(Bedroom note) {
    return api.save(note);
  }

  update(Bedroom note) {
    return api.update(note);
  }

  delete(int id) {
    return api.delete(id);
  }
}