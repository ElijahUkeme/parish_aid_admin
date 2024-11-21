import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:parish_aid_admin/core/json_checker/json_checker.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_bloc.dart';
import 'package:parish_aid_admin/features/auth/data/repository/auth_repository_impl.dart';
import 'package:parish_aid_admin/features/auth/data/sources/auth_local_source.dart';
import 'package:parish_aid_admin/features/auth/data/sources/auth_remote_source.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/forgot_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/login_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/logout_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/request_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/reset_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/sign_up_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_user.dart';
import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_bloc.dart';
import 'package:parish_aid_admin/features/billing/data/repository/billing_plans_repository_impl.dart';
import 'package:parish_aid_admin/features/billing/data/sources/billing_plans_remote_source.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_billing_plans.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_subscriptions.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/initiate_billing_subscription.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_billing_plan.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_subscription.dart';
import 'package:parish_aid_admin/features/diocese/app/bloc/diocese_bloc.dart';
import 'package:parish_aid_admin/features/diocese/data/repository/diocese_repository_impl.dart';
import 'package:parish_aid_admin/features/diocese/data/sources/diocese_local_source.dart';
import 'package:parish_aid_admin/features/diocese/data/sources/diocese_remote_source.dart';
import 'package:parish_aid_admin/features/diocese/domain/repository/diocese_repository.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/get_diocese.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/show_diocese.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/data/repository/group_repository_impl.dart';
import 'package:parish_aid_admin/features/group/data/sources/group_remote_sources.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group_admins.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_groups.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/show_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group_admin.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/data/repository/home_repository_impl.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_local_source.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_remote_source.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parishes.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_list.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_stat.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/print_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/show_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_verification_code.dart';
import 'package:parish_aid_admin/features/lga/app/bloc/lga_bloc.dart';
import 'package:parish_aid_admin/features/lga/data/repository/lga_repository_impl.dart';
import 'package:parish_aid_admin/features/lga/data/sources/lga_local_source.dart';
import 'package:parish_aid_admin/features/lga/data/sources/lga_remote_source.dart';
import 'package:parish_aid_admin/features/lga/domain/repository/lga_repository.dart';
import 'package:parish_aid_admin/features/lga/domain/usecases/get_lga.dart';
import 'package:parish_aid_admin/features/onboarding/app/bloc/onboarding_bloc.dart';
import 'package:parish_aid_admin/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:parish_aid_admin/features/onboarding/data/sources/onboarding_local_source.dart';
import 'package:parish_aid_admin/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:parish_aid_admin/features/onboarding/domain/usecases/register_parish.dart';
import 'package:parish_aid_admin/features/onboarding/home/app/bloc/onboarding_parish_home_bloc.dart';
import 'package:parish_aid_admin/features/onboarding/home/data/repository/onboarding_parish_home_repository_impl.dart';
import 'package:parish_aid_admin/features/onboarding/home/data/sources/onboarding_parish_home_local_source.dart';
import 'package:parish_aid_admin/features/onboarding/home/data/sources/onboarding_parish_home_remote_source.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/repository/onboarding_parish_home_repository.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish_by_uid.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/create_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/data/repository/parishioner_repository_impl.dart';
import 'package:parish_aid_admin/features/parishioner/data/sources/parishioner_remote_source.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/delete_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioners.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/update_parishioner.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_bloc.dart';
import 'package:parish_aid_admin/features/state/data/repository/state_repository_impl.dart';
import 'package:parish_aid_admin/features/state/data/sources/state_local_source.dart';
import 'package:parish_aid_admin/features/state/data/sources/state_remote_source.dart';
import 'package:parish_aid_admin/features/state/domain/repository/state_repository.dart';
import 'package:parish_aid_admin/features/state/domain/usecases/get_state.dart';
import 'package:parish_aid_admin/features/town/app/bloc/town_bloc.dart';
import 'package:parish_aid_admin/features/town/data/repository/town_repository_impl.dart';
import 'package:parish_aid_admin/features/town/data/sources/town_local_source.dart';
import 'package:parish_aid_admin/features/town/data/sources/town_remote_source.dart';
import 'package:parish_aid_admin/features/town/domain/repository/town_repository.dart';
import 'package:parish_aid_admin/features/town/domain/usecases/get_town.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/features/users/data/repository/user_auth_repository_impl.dart';
import 'package:parish_aid_admin/features/users/data/sources/user_auth_local_source.dart';
import 'package:parish_aid_admin/features/users/data/sources/user_auth_remote_source.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/fetch_account.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_account_preview.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_forgot_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_logout.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_reset_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_verify_otp.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/onboarding/data/sources/onboarding_remote_source.dart';
import 'features/parishioner/domain/usecases/create_parishioner.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //AuthBloc injection
  sl.registerFactory(() => AuthBloc(
      verifyUser: sl(),
      loginUser: sl(),
      signUpUser: sl(),
      logoutUser: sl(),
      forgotPassword: sl(),
      resetPassword: sl(),
      verifyOtp: sl(),
      requestOtp: sl()));

  //HomeBloc Injection
  sl.registerFactory(() => HomeBloc(
      getParishes: sl(),
      getParish: sl(),
      updateParish: sl(),
      createParish: sl(),
      approveParish: sl(),
      deleteParish: sl(),
      createVerificationCode: sl(),
      updateVerificationCode: sl(),
      printVerificationCode: sl(),
      getVerificationCodeList: sl(),
      getVerificationCodeStat: sl(),
      showVerificationCode: sl(),
      deleteVerificationCode: sl()));

  //OnboardingBloc Injection
  sl.registerFactory(() => OnboardingBloc(registerParish: sl()));

  //OnboardingHomeBloc Injection
  sl.registerFactory(() => OnboardingParishHomeBloc(
      getOnboardingParish: sl(), getOnboardingParishByUid: sl()));

  //DioceseBloc
  sl.registerFactory(() => DioceseBloc(getDiocese: sl(), showDiocese: sl()));

  //StateBloc Injection
  sl.registerFactory(() => StateBloc(getState: sl()));

  //LocalGovernmentBloc Injection
  sl.registerFactory(() => LgaBloc(getLga: sl()));

  //TownBloc Injection
  sl.registerFactory(() => TownBloc(getTown: sl()));

  //EndUsersBloc
  sl.registerFactory(() => UserAuthBloc(
      userLogin: sl(),
      fetchAccount: sl(),
      userAccountPreview: sl(),
      userAuthLogout: sl(),
      userAuthForgotPassword: sl(),
      userAuthResetPassword: sl(),
      userAuthVerifyOtp: sl()));

  //Group Bloc Injection
  sl.registerLazySingleton(() => GroupBloc(
      createGroup: sl(),
      updateGroup: sl(),
      getGroup: sl(),
      getGroups: sl(),
      deleteGroup: sl(),
      updateGroupAdmin: sl(),
      getGroupAdmins: sl(),
      showGroupAdmin: sl(),
      deleteGroupAdmin: sl(),
      createGroupAdmin: sl()));

  //Parishioner Bloc Injection
  sl.registerLazySingleton(() => ParishionerBloc(
      createParishioner: sl(),
  updateParishioner: sl(),
      getParishioners: sl(),
      getParishioner: sl(),
      deleteParishioner: sl()));

  //Billing Plans Bloc Injection
  // sl.registerLazySingleton(()=>BillingPlansBloc(
  //     getBillingPlans: sl(),
  //     showBillingPlan: sl(),
  //     getSubscription: sl(),
  //     showSubscription: sl(),
  //     initiateBillingSubscription: sl()));

  sl.registerFactory(()=>BillingPlansBloc(
      getBillingPlans: sl(),
      showBillingPlan: sl(),
      getSubscription: sl(),
      showSubscription: sl(),
      initiateBillingSubscription: sl()));

  //Auth Usecases
  sl.registerLazySingleton(() => VerifyUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => SignUpUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => RequestOtp(sl()));

  //HomePage Usecases
  sl.registerLazySingleton(() => GetParishes(sl()));
  sl.registerLazySingleton(() => GetParish(sl()));
  sl.registerLazySingleton(() => UpdateParish(sl()));
  sl.registerLazySingleton(() => CreateParish(sl()));
  sl.registerLazySingleton(() => ApproveParish(sl()));
  sl.registerLazySingleton(() => DeleteParish(sl()));
  sl.registerLazySingleton(() => CreateVerificationCode(sl()));
  sl.registerLazySingleton(() => UpdateVerificationCode(sl()));
  sl.registerLazySingleton(() => PrintVerificationCode(sl()));
  sl.registerLazySingleton(() => GetVerificationCodeList(sl()));
  sl.registerLazySingleton(() => GetVerificationCodeStat(sl()));
  sl.registerLazySingleton(() => ShowVerificationCode(sl()));
  sl.registerLazySingleton(() => DeleteVerificationCode(sl()));

  //Onbaording Usecases
  sl.registerLazySingleton(() => RegisterParish(sl()));

  //Onboarding Usecases Home
  sl.registerLazySingleton(() => GetOnboardingParish(sl()));
  sl.registerLazySingleton(() => GetOnboardingParishByUid(sl()));

  //Diocese Usecases
  sl.registerLazySingleton(() => GetDiocese(sl()));
  sl.registerLazySingleton(() => ShowDiocese(dioceseRepository: sl()));

  //State Usecases
  sl.registerLazySingleton(() => GetState(stateRepository: sl()));

  //LocalGovernment Usecases
  sl.registerLazySingleton(() => GetLga(lgaRepository: sl()));

  //Town Usecases
  sl.registerLazySingleton(() => GetTown(townRepository: sl()));

  //EndUsers Usecases
  sl.registerLazySingleton(() => UserLogin(userAuthRepository: sl()));
  sl.registerLazySingleton(() => FetchAccount(userAuthRepository: sl()));
  sl.registerLazySingleton(() => UserAccountPreview(userAuthRepository: sl()));
  sl.registerLazySingleton(() => UserAuthLogout(userAuthRepository: sl()));
  sl.registerLazySingleton(
      () => UserAuthForgotPassword(userAuthRepository: sl()));
  sl.registerLazySingleton(
      () => UserAuthResetPassword(userAuthRepository: sl()));
  sl.registerLazySingleton(() => UserAuthVerifyOtp(userAuthRepository: sl()));

  //Group Usescases
  sl.registerLazySingleton(() => CreateGroup(sl()));
  sl.registerLazySingleton(() => UpdateGroup(sl()));
  sl.registerLazySingleton(() => GetGroup(sl()));
  sl.registerLazySingleton(() => GetGroups(sl()));
  sl.registerLazySingleton(() => DeleteGroup(sl()));
  sl.registerLazySingleton(() => UpdateGroupAdmin(sl()));
  sl.registerLazySingleton(() => GetGroupAdmins(sl()));
  sl.registerLazySingleton(() => ShowGroupAdmin(sl()));
  sl.registerLazySingleton(() => DeleteGroupAdmin(sl()));
  sl.registerLazySingleton(() => CreateGroupAdmin(sl()));


  //Parishioners Usecases
  sl.registerLazySingleton(() => CreateParishioner( sl()));
  sl.registerLazySingleton(() => UpdateParishioner(sl()));
  sl.registerLazySingleton(() => GetParishioners(sl()));
  sl.registerLazySingleton(() => GetParishioner(sl()));
  sl.registerLazySingleton(() => DeleteParishioner(sl()));

  //Billing Plans Usecases
  sl.registerLazySingleton(()=>GetBillingPlans(sl()));
  sl.registerLazySingleton(()=>ShowBillingPlan(sl()));
  sl.registerLazySingleton(()=>ShowSubscription(sl()));
  sl.registerLazySingleton(()=>GetSubscriptions(sl()));
  sl.registerLazySingleton(()=>InitiateBillingSubscription(sl()));

  //Auth Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authRemoteSource: sl(), networkInfo: sl(), authLocalSource: sl()));

  //HomePage Repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      homeRemoteSource: sl(), homeLocalSource: sl(), networkInfo: sl()));

  //Onboarding Repository
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(
      onboardingRemoteSource: sl(),
      onboardingLocalSource: sl(),
      networkInfo: sl()));

//Onboarding Home Repository
  sl.registerLazySingleton<OnBoardingParishHomeRepository>(() =>
      OnboardingParishHomeRepositoryImpl(
          onboardingParishHomeRemoteSource: sl(),
          onboardingParishHomeLocalSource: sl(),
          networkInfo: sl()));

  //Diocese Respository
  sl.registerLazySingleton<DioceseRepository>(() => DioceseRepositoryImpl(
      dioceseRemoteSource: sl(), dioceseLocalSource: sl(), networkInfo: sl()));

  //State Repository
  sl.registerLazySingleton<StateRepository>(() => StateRepositoryImpl(
      stateRemoteSource: sl(), stateLocalSource: sl(), networkInfo: sl()));

  // LocalGovernment Repository
  sl.registerLazySingleton<LgaRepository>(() => LgaRepositoryImpl(
      lgaRemoteSource: sl(), lgaLocalSource: sl(), networkInfo: sl()));

  //Town Repository
  sl.registerLazySingleton<TownRepository>(() => TownRepositoryImpl(
      townRemoteSource: sl(), townLocalSource: sl(), networkInfo: sl()));

  //EndUsers Repository
  sl.registerLazySingleton<UserAuthRepository>(() => UserAuthRepositoryImpl(
      networkInfo: sl(),
      userAuthRemoteSource: sl(),
      userAuthLocalSource: sl()));

  //Group Repository
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(networkInfo: sl(),
      groupRemoteSource: sl()));

  //Parishioners Repository
  sl.registerLazySingleton<ParishionerRepository>(() => ParishionerRepositoryImpl(
      parishionerRemoteSource: sl(),
      networkInfo: sl()));

  //Billing plans Repository
  sl.registerLazySingleton<BillingPlansRepository>(()=>BillingPlansRepositoryImpl(
      billingPlansRemoteSource: sl(),
      networkInfo: sl()));

  // Auth RemoteSources
  sl.registerLazySingleton<AuthRemoteSource>(
      () => AuthRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //HomePage RemoteSources
  sl.registerLazySingleton<HomeRemoteSource>(
      () => HomeRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Onboarding RemoteSource
  sl.registerLazySingleton<OnboardingRemoteSource>(
      () => OnboardingRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Onboarding home RemoteSource
  sl.registerLazySingleton<OnboardingParishHomeRemoteSource>(() =>
      OnboardingParishHomeRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Diocese RemoteSource
  sl.registerLazySingleton<DioceseRemoteSource>(
      () => DioceseRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //State RemoteSource
  sl.registerLazySingleton<StateRemoteSource>(
      () => StateRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Lga RemoteSource
  sl.registerLazySingleton<LgaRemoteSource>(
      () => LgaRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Town RemoteSource
  sl.registerLazySingleton<TownRemoteSource>(
      () => TownRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //EndUsers RemoteSource
  sl.registerLazySingleton<UserAuthRemoteSource>(
      () => UserAuthRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Group RemoteSource
  sl.registerLazySingleton<GroupRemoteSource>(() =>GroupRemoteSourceImpl(client: sl(), jsonChecker: sl()));

  //Parishioners RemoteSource
  sl.registerLazySingleton<ParishionerRemoteSource>(() =>ParishionerRemoteSourceImpl(client: sl(), jsonChecker: sl()) );

  //Billing plans RemoteSource
  sl.registerLazySingleton<BillingPlansRemoteSource>(()=>BillingPlansRemoteSourceImpl(
      client: sl(),
      jsonChecker: sl()));

  //Auth LocalSource
  sl.registerLazySingleton<AuthLocalSource>(
    () => AuthLocalSourceImpl(),
  );

  //HomePage LocalSource
  sl.registerLazySingleton<HomeLocalSource>(() => HomeLocalSourceImpl());

  //Onboarding LocalSource
  sl.registerLazySingleton<OnboardingLocalSource>(
      () => OnboardingLocalSourceImpl());

  //Onboarding home LocalSource
  sl.registerLazySingleton<OnboardingParishHomeLocalSource>(
      () => OnboardingParishHomeLocalSourceImpl());

  //Diocese LocalSource
  sl.registerLazySingleton<DioceseLocalSource>(() => DioceseLocalSourceImpl());

  //State LocalSource
  sl.registerLazySingleton<StateLocalSource>(() => StateLocalSourceImpl());

  //LocalGovernment LocalSource
  sl.registerLazySingleton<LgaLocalSource>(() => LgaLocalSourceImpl());

  //Town LocalSource
  sl.registerLazySingleton<TownLocalSource>(() => TownLocalSourceImpl());

  //EndUsers LocalSource
  sl.registerLazySingleton<UserAuthLocalSource>(
      () => UserAuthLocalSourceImpl());

  //core
  //Application [core]
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<JsonChecker>(() => JsonCheckerImpl(sl()));

  //External
  //Application External
  final sharedPreference = SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => json);
}
