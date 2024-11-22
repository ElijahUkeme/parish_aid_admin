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
final getShowEnPoint = '$baseUrl/admin/coperate/parishes/show';
final updateParishEndPoint = '$baseUrl/admin/coperate/parishes/update';
final createParishEndPoint = '$baseUrl/admin/coperate/parishes/create';
final approveParishEndPoint = '$baseUrl/admin/coperate/parishes/approve';
final deleteParishEndPoint = '$baseUrl/admin/coperate/parishes/destroy';
final registerParishEndPoint = '$baseUrl/parish/register';
final onboardingParishGetEndPoint = '$baseUrl/parish/30/index';
final getParishByUuidEndPoint = '$baseUrl/parish/get-by-uuid';
final dioceseListEndPoint = '$baseUrl/admin/coperate/dioceses';
final dioceseGetShowEndPoint = '$baseUrl/admin/coperate/dioceses/show/1';
final getStateEndPoint = '$baseUrl/location/states/';
final getLgaEndPoint = '$baseUrl/location/lgas';
final getTownEndPoint = '$baseUrl/location/towns';
final createGroupEndPoint = '$baseUrl/parish';
final updateGroupEndPoint = '$baseUrl/parish';
final getGroupEndPoint = '$baseUrl/parish';
final getGroupsEndPoint = '$baseUrl/parish';
final deleteGroupEndPoint = '$baseUrl/parish';
final updateGroupAdminEndPoint = '$baseUrl/parish';
final getGroupAdminsEndPoint = '$baseUrl/parish';
final showGroupAdminEndPoint = '$baseUrl/parish';
final deleteGroupAdminEndPoint = '$baseUrl/parish';
final createGroupAdminEndPoint = '$baseUrl/parish';
final createVerificationCodeEndPoint = '$baseUrl/parish';
final updateVerificationCodeEndPoint = '$baseUrl/parish';
final printVerificationCodeEndPoint = '$baseUrl/parish';
final verificationCodeListEndPoint = '$baseUrl/parish';
final getStatsEndPoint = '$baseUrl/parish';
final showVerificationCodeEndPoint = '$baseUrl/parish';
final deleteVerificationCodeEndPoint = '$baseUrl/parish';

//Parishioners Endpoint
final createParishionerEndPoint = '$baseUrl/parish';
final updateParishionerEndPoint = '$baseUrl/parish';
final getParishionersEndPoint = '$baseUrl/parish';
final getParishionerEndPoint = '$baseUrl/parish';
final deleteParishionerEndPoint = '$baseUrl/parish';

//Users Endpoint
final userLoginEndPoint = '$baseUrl/user/auth/login';
final userAccountFetchEndPoint = '$baseUrl/user/auth/account/fetch';
final userPreviewEndPoint = '$baseUrl/user/account/preview';
final userAuthLogoutEndPoint = '$baseUrl/user/auth/logout';
final userAuthForgotPasswordEndPoint = '$baseUrl/user/auth/password/forgot';
final userAuthResetPasswordEndPoint = '$baseUrl/user/auth/password/reset';
final userAuthOtpVerifyEndPoint = '$baseUrl/user/auth/otp/verify';
final userAuthOtpRequestEndPoint = '$baseUrl/user/auth/otp/request';

//Billings Endpoint
final getBillingsEndPoint = '$baseUrl/parish';
final showBillingEndPoint = '$baseUrl/parish';

//Subscriptions EndPoint
final getSubscriptionsEndPoint = '$baseUrl/parish';
final showSubscriptionEndPoint = '$baseUrl/parish';
final initiateSubscriptionEndPoint = '$baseUrl/parish';

//Transactions Endpoint
final getTransactionsEndPoint = '$baseUrl/parish';