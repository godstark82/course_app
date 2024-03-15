import 'package:course_app/firebase_options.dart';
import 'package:course_app/functions/init.dart';
import 'package:course_app/provider/bottom_bar_provider.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/home/components/onboarding.dart';
import 'package:course_app/screens/login/login.dart';
import 'package:course_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider, GoogleAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
    GoogleProvider(
        clientId:
            '499590581626-5vkqnif37pcdtk39em6tevr03d6skte8.apps.googleusercontent.com',
        redirectUri: 'https://courseapp-21eb1.firebaseapp.com/__/auth/handler'),
  ]);
  await Hive.initFlutter();
  await Hive.openBox('cache');
  await InitClass.init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<QuizProvider>(create: (_) => QuizProvider())
      ],
      child: GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Notepediax',
          theme: theme,
          routes: routes,
          // home: const OnBoarding()),
          initialRoute: Hive.box('cache').get('firstLaunch') == false
              ? (FirebaseAuth.instance.currentUser != null
                  ? '/home'
                  : '/sign-in')
              : '/onboarding'),
    );
  }
}

final routes = {
  '/onboarding': (context) => const OnBoarding(),
  '/sign-in': (context) => const LoginScreen(),
  '/profile': (context) => ProfileScreen(
        showDeleteConfirmationDialog: true,
        appBar: AppBar(title: const Text('Profile')),
        showUnlinkConfirmationDialog: true,
        actions: [
          SignedOutAction((context) {
            Get.offAllNamed('/sign-in');
          }),
          AccountDeletedAction((context, user) async {
            Get.offAllNamed('/sign-in');
          })
        ],
      ),
  '/home': (context) => const Home(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),
  '/phone': (context) => PhoneInputScreen(
        actions: [
          SMSCodeRequestedAction((context, action, flowKey, phone) {
            Get.toNamed('/sms', arguments: {
              'action': action,
              'flowKey': flowKey,
              'phone': phone,
            });
          })
        ],
      ),
  '/sms': (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return SMSCodeInputScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.offAllNamed('/home');
        })
      ],
      flowKey: arguments?['flowKey'],
      action: arguments?['action'],
    );
  }
};

final ThemeData theme = ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 241, 249))
    .copyWith(textTheme: GoogleFonts.latoTextTheme());
