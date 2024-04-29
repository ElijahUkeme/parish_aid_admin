import 'package:flutter/cupertino.dart';
import 'package:parish_aid_admin/core/api/api_base.dart';
import 'package:parish_aid_admin/core/utils/enums.dart';
import 'package:parish_aid_admin/service/storage_service.dart';
import 'package:parish_aid_admin/injection_container.dart' as di;

class Global {
  static late StorageService service;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    const env = Environment.test;
    service = await StorageService().initSharedPreference();

    //initialize service locator
    await di.init();

    //initialize all assets and LIVE or TEST environment
    initApi(env);
  }
}
