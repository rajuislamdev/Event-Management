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
}

final hiveServiceProvider = Provider((ref) => HiveService(ref));
