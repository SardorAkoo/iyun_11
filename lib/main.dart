import 'package:flutter/material.dart';
import 'package:iyun_11/controllers/course_controller.dart';
import 'package:iyun_11/controllers/note_controller.dart';
import 'package:iyun_11/controllers/plan_controller.dart';
import 'package:iyun_11/notifier/theme_notifier.dart';
import 'package:iyun_11/servise/auth_http_services.dart';
import 'package:iyun_11/views/home_screen.dart';
import 'package:iyun_11/views/login_screen.dart';
import 'package:iyun_11/views/plans_screen.dart';
import 'package:iyun_11/views/reast_password.dart';
import 'package:provider/provider.dart';
import 'views/course_screen.dart';
import 'views/note_screen.dart';
import 'views/quiz_screen.dart';
import 'views/settings_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteController()),
        ChangeNotifierProvider(create: (_) => PlanController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authHttpServices = AuthHttpServices();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    authHttpServices.checkAuth().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      
      theme: themeNotifier.currentTheme,
      home: isLoggedIn ? HomeScreen() : const LoginScreen(),
      routes: {
        '/notes': (context) => NoteScreen(),
        '/plans': (context) => PlansScreen(),
        '/courses': (context) => CourseScreen(),
        '/settings': (context) =>
            SettingsScreen(toggleTheme: themeNotifier.toggleTheme),
        '/quiz': (context) => QuizScreen(),
        '/reast_pass': (context) => const ReastPassword(),
      },
    );
  }
}
