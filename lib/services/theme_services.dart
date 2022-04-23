import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  String key = 'isDarkMode';

  savetheme(bool isdark) {
    _box.write(key, isdark);
  }

  bool loadingtheme() {
    return _box.read<bool>(key) ?? false;
  }

  ThemeMode get mode => loadingtheme() ? ThemeMode.dark : ThemeMode.light;
  void swichmode() {
    Get.changeThemeMode(loadingtheme() ? ThemeMode.light : ThemeMode.dark);
    savetheme(!loadingtheme());
  }
}
