import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static late SharedPreferences _pref;
  static StorageService get to => Get.find<StorageService>();

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  void savePref(String key, String value, {bool checkExisted = false}) {
    if (checkExisted && _pref.containsKey(key)) {
      return;
    }
    _pref.setString(key, value);
  }

  String? getPref(String key) {
    return _pref.getString(key);
  }

  void clearPref(String key) {
    _pref.remove(key);
  }

  void clearAllPref() {
    _pref.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
