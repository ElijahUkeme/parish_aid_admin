//Authentication Endpoints
import 'package:parish_aid_admin/core/api/api_base.dart';

final userLogin = '$baseUrl/admin/auth/login';
final userSignUp = '$baseUrl/admin/auth/register';
final userPreview = '$baseUrl/admin/account/preview';
final signOut = '$baseUrl/admin/auth/logout';
final forgotPasswordEndPoint = '$baseUrl/admin/auth/password/forgot';
final passwordResetEndPoint = '$baseUrl/admin/auth/password/reset';
final otpVerifyEndPoint = '$baseUrl/admin/auth/otp/verify';
final otpRequestEndPoint = '$baseUrl/admin/auth/otp/request';
final parishListEndPoint = '$baseUrl/admin/coperate/parishes';
final getShowEnPoint = '$baseUrl/admin/coperate/parishes/show/';
final updateParishEndPoint = '$baseUrl/admin/coperate/parishes/updata';
final createParishEndPoint = '$baseUrl/admin/coperate/parishes/create';
final approveParishEndPoint = '$baseUrl/admin/coperate/parishes/approve';
final deleteParishEndPoint = '$baseUrl/admin/coperate/parishes/destroy';
final registerParishEndPoint = '$baseUrl/parish/register';
final onboardingParishGetEndPoint = '$baseUrl/parish/30/index';
final getParishByUuidEndPoint = '$baseUrl/parish/get-by-uuid';
final dioceseListEndPoint = '$baseUrl/admin/coperate/dioceses';
final dioceseGetShowEndPoint = '$baseUrl/admin/coperate/dioceses/show/1';
final getStateEndPoint = '$baseUrl/location/states';
final getLgaEndPoint = '$baseUrl/location/lgas';
final getTownEndPoint = '$baseUrl/location/towns';

//Users Endpoint
final userLoginEndPoint = '$baseUrl/user/auth/login';
final userAccountFetchEndPoint = '$baseUrl/user/auth/account/fetch';
final userPreviewEndPoint = '$baseUrl/user/account/preview';
final userAuthLogoutEndPoint = '$baseUrl/user/auth/logout';
final userAuthForgotPasswordEndPoint = '$baseUrl/user/auth/password/forgot';
final userAuthResetPasswordEndPoint = '$baseUrl/user/auth/password/reset';
final userAuthOtpVerifyEndPoint = '$baseUrl/user/auth/otp/verify';
final userAuthOtpRequestEndPoint = '$baseUrl/user/auth/otp/request';
