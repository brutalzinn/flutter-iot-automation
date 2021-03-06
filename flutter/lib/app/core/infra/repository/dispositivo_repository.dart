

import 'package:application/app/core/infra/provider/dispositivo_provider.dart';
import 'package:application/app/model/database/dispositivo_model.dart';

class DispositivoRepository {

  final DispositivoProvider api;
  
  DispositivoRepository(this.api);

  getAllDevicesById(int deviceId) {
    return api.getAllDevicesById(deviceId);
  }

  getAllFavoriteDevices() {
    return api.getAllFavoriteDevices();
  }
  
  save(Dispositivo device) {
    return api.save(device);
  }

  update(Dispositivo device) {
    return api.update(device);
  }

  delete(int id) {
    return api.delete(id);
  }
}