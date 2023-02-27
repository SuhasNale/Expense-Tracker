import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/routes.dart';
import 'app/ui/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      home: HomePage(),
    );
  }
}
