/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */
import 'dart:developer' as dev;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorage({required this.storage});

  final String userTokenKey = "user-token-key";

  Future<String?> getUserToken() async {
    try {
      final result = await storage.read(key: userTokenKey);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<void> setUserToken(String value) async {
    try {
      await storage.write(key: userTokenKey, value: value);
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
