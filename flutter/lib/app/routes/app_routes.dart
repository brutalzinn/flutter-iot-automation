part of './app_pages.dart';

abstract class Routes{

  static const initial = '/';
  static const home = '/home';
  static const devicesList = '/devices/:roomId';
  static const devicesEdit = '/devices/:roomId/:deviceId';


}