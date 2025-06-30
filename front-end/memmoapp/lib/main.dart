import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memmoapp/pages/home_page.dart';
import 'package:memmoapp/utilities/routes.dart' as routes;
import 'package:memmoapp/utilities/theme.dart';
import 'utilities/dependencies.dart' as dependencies;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Memo App',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: dependencies.InitialBindings(),
      getPages: routes.getPages,
      home: const HomePage(),
      defaultTransition: Transition.fadeIn,
    );
  }
}
