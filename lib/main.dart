import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_config/configs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.key,
      getPages: Pages.allPages,
      initialRoute: Routes.home,
      enableLog: true,
      defaultTransition: Transition.upToDown,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
