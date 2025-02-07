import 'package:defiastra_hackathon/core/app_routes/app_routes.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/splash/page_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      key: const ValueKey("application-screen-util"),
      designSize: Size(
        MediaQuery.sizeOf(context).width * 0.9,
        MediaQuery.sizeOf(context).height * 0.9,
      ),
      child: GetMaterialApp(
        title: 'DeFi Casino',
        darkTheme: AppThemeData(isDark: false).themeData,
        theme: AppThemeData().themeData,
        getPages: AppRoutes.appRoutePages,
        initialRoute: "/",
      ),
    );
  }
}