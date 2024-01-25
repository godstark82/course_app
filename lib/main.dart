import 'package:course_app/constants/db.dart';
import 'package:course_app/firebase_options.dart';
import 'package:course_app/functions/init.dart';
import 'package:course_app/provider/bottom_bar_provider.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:course_app/screens/authentication/root.dart';
import 'package:course_app/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('cache');
  await InitClass.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CourseProvider>(create: (_) => CourseProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<CarouselProvider>(
            create: (_) => CarouselProvider()),
        ChangeNotifierProvider<BottomBarProvider>(
            create: (_) => BottomBarProvider()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notepediax',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: DatabaseClass.isLogined == true
              ? const Home()
              : const AuthenticationScreen()),
    );
  }
}
