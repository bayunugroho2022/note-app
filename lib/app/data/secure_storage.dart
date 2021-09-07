import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */
class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() =>
      _instance ??= SecureStorage._(FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _uidKey = 'UID';
  static const _imageKey = 'IMAGE';
  static const _emailKey = 'EMAIL';
  static const _nameKey = 'Name';

  Future<void> persistNameAndUid(String name,String uid) async {
    await _storage.write(key: _nameKey, value: name);
    await _storage.write(key: _uidKey, value: uid);
  }

  Future<bool> hasUid() async {
    var value = await _storage.read(key: _uidKey);
    return value != null;
  }

  Future<String?> getName() async {
    return _storage.read(key: _nameKey);
  }

  Future<String?> getUid() async {
    return _storage.read(key: _uidKey);
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}
