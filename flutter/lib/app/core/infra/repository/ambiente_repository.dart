import 'package:application/app/core/infra/provider/ambiente_provider.dart';
import 'package:application/app/model/database/ambiente_model.dart';

class AmbienteRepository {

  final AmbienteProvider api;
  
  AmbienteRepository(this.api);

  getAll() {
    return api.getAll();
  }

  save(Ambiente note) {
    return api.save(note);
  }

  update(Ambiente note) {
    return api.update(note);
  }

  delete(int id) {
    return api.delete(id);
  }
}