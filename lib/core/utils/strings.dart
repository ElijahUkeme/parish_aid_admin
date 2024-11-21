import 'dart:io';

String apiKey = Platform.isAndroid ? ANDROID_KEY : IOS_KEY;
const String IOS_KEY = "";
const String ANDROID_KEY = "";

//Errors and Exceptions
const String networkFailure = "Network Failure";
const String cacheFailure = 'Cache Failure';
const String serverFailure = 'Server Failure';
const String networkError = 'Poor Internet Connection';
const String timeoutError = 'Request Timeout';
const String noInternetError = 'No Internet Connection';
const String processFailure = 'Process Failure';
const String formatError = 'Format Error';
const String unknownError = 'Unknown Error';
const String invalidMessage = 'An Error Occurred';
const String serverErrorMsg = 'Oops! Something went wrong, please try again';
const unsupportedAccessErrorCode = 400;

//CacheManager keys
const String userTokenKey = 'user_token_key';
const String profileKey = 'profile_key';
const String userKey = 'user_key';

//Users CacheManager keys
const String endUserTokenKey = 'end-user-token-key';
const String endUserProfileKey = 'end-user-profile';
const String endUserKey = 'end-user-key';


