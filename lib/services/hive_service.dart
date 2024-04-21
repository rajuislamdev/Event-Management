import 'package:event_management/config/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final Ref ref;
  HiveService(this.ref);

  Future setUserInfo({
    required String id,
    required String accountType,
  }) async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    appSettingsBox
        .put(AppConstants.userInfo, {'id': id, 'accountType': accountType});
  }

  Future<Map<dynamic, dynamic>?> getUserInfo() async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    final userInfo =
        appSettingsBox.get(AppConstants.userInfo) as Map<dynamic, dynamic>?;
    if (userInfo != null) {
      return userInfo;
    }
    return null;
  }

  String? getUserId() {
    final box = Hive.box(AppConstants.appSettingsBox);
    var userinf = box.get(AppConstants.userInfo);

    return userinf['id'];
  }

  Future<void> logout() async {
    Hive.box(AppConstants.appSettingsBox).clear();
  }
}

final hiveServiceProvider = Provider((ref) => HiveService(ref));
