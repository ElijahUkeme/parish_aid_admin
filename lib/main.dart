import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parish_aid_admin/routes/page.dart';
import 'package:parish_aid_admin/service/global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
          designSize: const Size(375, 720),
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    iconTheme: const IconThemeData(color: Colors.black),
                    appBarTheme: const AppBarTheme(
                        elevation: 0, backgroundColor: Colors.white)),
                onGenerateRoute: AppPages().generateRouteSettings,
              )),
    );
  }
}
