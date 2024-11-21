
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

import '../../../../core/cache_manager/cache_manager.dart';
import '../../../../core/helpers/custom_widgets.dart';

abstract class UserAuthLocalSource {
  Future<bool> clearAuthToken();
  Future<Data?> getCachedAuthUser();
  Future<bool> cachedUserAuth(Data userAuthData);
}

class UserAuthLocalSourceImpl extends UserAuthLocalSource {

  @override
  Future<bool> cachedUserAuth(Data userAuthData) async{
    return await CacheManager.instance.storePref(userKey, userAuthData.toJson);
  }

  @override
  Future<bool> clearAuthToken() async {
    await CacheManager.instance.storePref(userKey, '');
    await CacheManager.instance.storePref(userTokenKey, '');
    return true;
  }

  @override
  Future<Data?> getCachedAuthUser() async {

    // final storedData = await CacheManager.instance.getPref(userKey) as String?;
    // if(storedData !=null && storedData.isNotEmpty){
    //   Data userInfo = Data.fromJsonObject(storedData);
    //   pp('The stored email is ${userInfo.user!.email}');
    //   pp('The stored token is ${userInfo.token}');
    //   pp('The stored name is ${userInfo.user!.firstName}');
    // }

    final authString =
    await CacheManager.instance.getPref(userKey) as String?;
    if (authString != null && authString.isNotEmpty) {
      return Data.fromJsonObject(authString);
    }
    return null;
  }
}
