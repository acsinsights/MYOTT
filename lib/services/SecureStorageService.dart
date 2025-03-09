import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// **Write Data to Secure Storage**
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// **Read Data from Secure Storage**
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// **Delete Data from Secure Storage**
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// **Clear All Stored Data**
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
