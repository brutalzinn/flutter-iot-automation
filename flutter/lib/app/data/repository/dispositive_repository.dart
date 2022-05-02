import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/provider/dispositive_provider.dart';

class DispositiveRepository {

  final DispositiveProvider api;
  
  DispositiveRepository(this.api);

  getAllDevicesById(int deviceId) {
    return api.getAllDevicesById(deviceId);
  }

  getAllFavoriteDevices() {
    return api.getAllFavoriteDevices();
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