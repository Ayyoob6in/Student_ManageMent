import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn/presentation/controller/detail_controller.dart';
import 'package:learn/presentation/views/details/details.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsController();
    Get.put(detailsController);
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(DetailsController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ScreenDisplay(),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

