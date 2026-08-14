import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_map_app/model/health_controller.dart';
import 'package:gps_map_app/model/vaccination_controller.dart';
import 'package:gps_map_app/view/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register controllers globally so Get.find() works everywhere
  Get.put(HealthController());
  Get.put(VaccinationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}
