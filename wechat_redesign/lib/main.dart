import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/pages/home_page.dart';
import 'package:wechat_redesign/pages/splash_screen_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/utils/material_color_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = AuthenticationModelImpl();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(PRIMARY_COLOR),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
      home: auth.isLoggedIn() ? const HomePage() : const SplashScreenPage(),
    );
  }
}
