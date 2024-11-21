import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/pages/forgot_password_page.dart';
import 'package:parish_aid_admin/features/auth/app/pages/reset_password_page.dart';
import 'package:parish_aid_admin/features/auth/app/pages/splash_page.dart';
import 'package:parish_aid_admin/features/auth/app/pages/welcome_page.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_billing_plans_page.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/page/create_group_page.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/lga/app/bloc/lga_bloc.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/auth_onboarding_page.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/card_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/create_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/parishioner_profile_page.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_bloc.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/routes/name.dart';

import '../entities/page_entity.dart';
import '../features/auth/app/bloc/auth_bloc.dart';
import '../features/auth/app/pages/auth_page.dart';
import '../injection_container.dart';

class AppPages {
  static List<PageEntity> route() {
    return [
      PageEntity(
          route: AppRoutes.PARISHIONER_CREATE,
          page: const CreateParishionerPage(),
          bloc: BlocProvider(create: (_) =>sl<ParishionerBloc>())),
      PageEntity(
          route: AppRoutes.PARISHIONER_PROFILE,
          page: const ParishionerProfilePage(),
          bloc: BlocProvider(create: (_) =>sl<ParishionerBloc>())),
       PageEntity(
           route: AppRoutes.GROUP,
           page: const CreateGroupPage(),
           bloc: BlocProvider(create: (_) => sl<LgaBloc>()),),
      PageEntity(
        route: AppRoutes.AUTH,
        page: const AuthPage(),
        bloc: BlocProvider(create: (_) => sl<AuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.ONBOARDING_AUTH,
        page: const AuthOnboardingPage(),
        bloc: BlocProvider(create: (_) => sl<UserAuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.AUTH,
        page: const AuthPage(),
        bloc: BlocProvider(create: (_) => sl<StateBloc>()),
      ),
      PageEntity(
        route: AppRoutes.GROUP,
        page: const CreateGroupPage(),
        bloc: BlocProvider(create: (_) => sl<GroupBloc>()),
      ),
      PageEntity(
        route: AppRoutes.HOME,
        page: const CardPage(),
        bloc: BlocProvider(create: (_) => sl<HomeBloc>()),
      ),
      PageEntity(
        route: AppRoutes.FORGOT_PASSWORD,
        page: const ForgotPasswordPage(),
        bloc: BlocProvider(create: (_) => sl<UserAuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.RESET_PASSWORD,
        page: const ResetPasswordPage(),
        bloc: BlocProvider(create: (_) => sl<UserAuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.GET_BILLING_PLANS,
        page: const GetBillingPlansPage(),
        bloc: BlocProvider(create: (_) => sl<BillingPlansBloc>()),
      )
    ];
  }

  //loop through all the blocs, add them into a list and then return it
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in route()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  Route<dynamic> generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = route().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        final matchedRoute = result.first;

        // Return the matched route's page
        return MaterialPageRoute(
            builder: (_) => matchedRoute.page, settings: settings);
      }
    }
    // If no valid route found
    return MaterialPageRoute(
        builder: (_) => const SplashPage(), settings: settings);
  }
  }
