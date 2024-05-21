import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/blocs/auth/login_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/pages/testing_page.dart';
import 'package:parish_aid_admin/features/auth/app/pages/splash_screen.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/card_page.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/navigation_drawer_page.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/features/users/app/pages/details_page.dart';
import 'package:parish_aid_admin/routes/name.dart';
import 'package:parish_aid_admin/screens/home/home_screen.dart';
import 'package:parish_aid_admin/screens/users/login_screen.dart';

import '../entities/page_entity.dart';
import '../features/auth/app/bloc/auth_bloc.dart';
import '../features/auth/app/pages/auth_page.dart';
import '../features/home/app/pages/home_page.dart';
import '../injection_container.dart';
import '../service/global.dart';

class AppPages {
  static List<PageEntity> route() {
    return [
      // PageEntity(
      //     route: AppRoutes.HOME,
      //     page: const HomeScreen(),
      //     bloc: BlocProvider(create: (_) =>const HomeBloc())),
      // PageEntity(
      //     route: AppRoutes.LOGIN,
      //     page: const LoginScreen(),
      //     bloc: BlocProvider(create: (_) => LoginBloc())),
      PageEntity(
        route: AppRoutes.AUTH,
        page: const AuthPage(),
        bloc: BlocProvider(create: (_) => sl<UserAuthBloc>()),
      ),
      PageEntity(
        route: AppRoutes.HOME,
        page: const CardPage(),
        bloc: BlocProvider(create: (_) => sl<HomeBloc>()),
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

  MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      //check for the route name matching when navigation get triggered
      var result = route().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print("valid route name is ${settings.name}");
        print("First log");
        bool deviceAlreadyOpen = Global.service.getIsUserAlreadyLoggedIn();
        if (result.first.route == AppRoutes.LOGIN && deviceAlreadyOpen) {
          bool isUserLoggedIn = Global.service.getIsUserAlreadyLoggedIn();
          if (isUserLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => const HomeScreen(), settings: settings);
          }
          print("Second log");
          return MaterialPageRoute(
              builder: (_) => const SplashScreen(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const SplashScreen(), settings: settings);
  }
}
