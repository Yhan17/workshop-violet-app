import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static late final String backendUrl;

  static Future<void> init({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);

    backendUrl = dotenv.env['BACKEND_URL']!;
  }
}
