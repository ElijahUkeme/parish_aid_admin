import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parish_aid_admin/features/auth/app/pages/splash_page.dart';
import 'package:parish_aid_admin/routes/page.dart';
import 'package:parish_aid_admin/service/global.dart';

import 'features/auth/app/pages/welcome_page.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        designSize: const Size(375, 720),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              iconTheme: const IconThemeData(color: Colors.black),
              appBarTheme: const AppBarTheme(
                  elevation: 0, backgroundColor: Colors.white),
            ),
            onGenerateRoute: AppPages().generateRouteSettings,
            home: const SplashPage(), // Initial route is SplashScreen
          );
        },
      ),
    );
  }
}
