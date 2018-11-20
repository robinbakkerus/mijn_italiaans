import 'vertaal_service_v2.dart';
import 'vertaal_service.dart';

abstract class IVertaalService {

  Future<String> vertaal(String text) async {return null;}

  factory IVertaalService() {
    return new VertaalService();
  }
}