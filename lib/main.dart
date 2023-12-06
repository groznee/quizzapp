import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/routes.dart';
import 'package:quizz_app/services/services.dart';
import 'package:quizz_app/shared/shared.dart';
import 'package:quizz_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // Error screen
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            catchError: (_, err) => Report(),
            initialData: Report(),
            child: const HomeMaterialWidget(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(home: LoadingScreen());
      },
    );
  }
}

class HomeMaterialWidget extends StatefulWidget {
  const HomeMaterialWidget({
    super.key,
  });

  @override
  HomeMaterialWidgetState createState() => HomeMaterialWidgetState();

  static HomeMaterialWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<HomeMaterialWidgetState>()!;
}

class HomeMaterialWidgetState extends State<HomeMaterialWidget> {
  // ThemeMode _themeMode = ThemeMode.system;
  ThemeData _themeData = themeDefault;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      theme: _themeData,
      // darkTheme: appThemeDark,
      // themeMode: _themeMode,
    );
  }

  void changeTheme(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }
}
