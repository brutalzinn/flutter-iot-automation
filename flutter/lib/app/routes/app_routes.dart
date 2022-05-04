part of './app_pages.dart';

abstract class Routes{

  static const initial = '/';
  static const deviceFavorite = '/device/favorite';
  static const devicesList = '/devices/:roomId';
  static const devicesEdit = '/devices/:roomId/:deviceId';


}