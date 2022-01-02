import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StringConstant {
  // ignore: constant_identifier_names
  static const BASEURL = 'http://168.138.22.111:8010/api';
  static const _storage = FlutterSecureStorage();
  static String token = '';
  static String role = '';

  static setToken(val) async {
    token = val;
    await _storage.write(key: 'token', value: val);
  }

  static Future<String?> getToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  static Future<String?> getRole() async {
    String? value = await _storage.read(key: 'role');
    return value;
  }

  static deleteStorage() async {
    await _storage.deleteAll();
  }

  static setRole(val) async {
    role = val;
    await _storage.write(key: 'role', value: val);
  }
}
