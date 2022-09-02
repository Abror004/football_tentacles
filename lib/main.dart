import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tentacles/screens/play_screen/play_screen.dart';
import 'package:football_tentacles/services/db_service.dart';
import 'package:football_tentacles/services/di_service.dart';
import 'package:football_tentacles/services/lang_service.dart';
import 'package:football_tentacles/services/root_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(DBService.DB_NAME);
  await RootService.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,])
      .then((_) {
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) =>
          GetMaterialApp(
            // supportedLocales: LangService.locales,
            debugShowCheckedModeBanner: false,
            title: 'Game',
            initialBinding: DIService(),
            home: const Game_Page(),
            translations: LangService(),
            locale: LangService.locale,
            fallbackLocale: LangService.fallbackLocale,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0,),
                child: child!,
              );
            },
          ),
    );
  }
}