import 'package:quizz_app/about/about.dart';
import 'package:quizz_app/profile/profile.dart';
import 'package:quizz_app/login/login.dart';
import 'package:quizz_app/topics/topics.dart';
import 'package:quizz_app/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};
