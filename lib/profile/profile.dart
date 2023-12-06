import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/services/services.dart';
import 'package:quizz_app/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return ProfileProfile(user: user, report: report, mounted: mounted);
          } else {
            return LandscapeProfile(
                user: user, report: report, mounted: mounted);
          }
        }),
      );
    } else {
      return const LoadingScreen();
    }
  }
}

class LandscapeProfile extends StatelessWidget {
  const LandscapeProfile({
    super.key,
    required this.user,
    required this.report,
    required this.mounted,
  });

  final User user;
  final Report report;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(bottom: 25),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('assets/congrats.gif')),
              ),
            ),
            Text(user.email ?? 'guest@anonymous.com',
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${report.total}',
                style: Theme.of(context).textTheme.displayMedium),
            Text('Quizzes Completed',
                style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
                label: const Text("logout"),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  visualDensity: const VisualDensity(vertical: -4),
                ),
                icon: const Icon(FontAwesomeIcons.skull, size: 14),
                label: const Text(
                  "delete profile",
                  textScaler: TextScaler.linear(0.75),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Are you sure you want delete your profile:",
                        textScaler: TextScaler.linear(0.75),
                      ),
                      TextButton(
                          onPressed: () async {
                            FirestoreService().deleteReportForUser(user.uid);
                            await user.delete();
                            await AuthService().user?.delete();
                            if (mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (route) => false);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    // duration: 2.seconds,
                                    content: Text(
                                  "All data deleted, the canvas is clear...",
                                  textScaler: TextScaler.linear(0.75),
                                )));
                            }
                          },
                          child: const Text(
                            "YES",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: const Text(
                            "NO",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )));
                },
              ),
            )
                .animate()
                .scale(duration: 1.5.seconds, curve: Curves.elasticOut)
                .fade(duration: 1.5.seconds),
          ],
        ),
      ],
    );
  }
}

class ProfileProfile extends StatelessWidget {
  const ProfileProfile({
    super.key,
    required this.user,
    required this.report,
    required this.mounted,
  });

  final User user;
  final Report report;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(top: 50, bottom: 25),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage('assets/congrats.gif')),
                ),
              ),
              Text(user.email ?? 'guest@anonymous.com',
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          Column(
            children: [
              Text('${report.total}',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
              label: const Text("logout"),
              onPressed: () async {
                await AuthService().signOut();
                if (mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                visualDensity: const VisualDensity(vertical: -4),
              ),
              icon: const Icon(FontAwesomeIcons.skull, size: 14),
              label: const Text(
                "delete profile",
                textScaler: TextScaler.linear(0.75),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Are you sure you want delete your profile:",
                      textScaler: TextScaler.linear(0.75),
                    ),
                    TextButton(
                        onPressed: () async {
                          FirestoreService().deleteReportForUser(user.uid);
                          await user.delete();
                          await AuthService().user?.delete();
                          if (mounted) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  // duration: 2.seconds,
                                  content: Text(
                                "All data deleted, the canvas is clear...",
                                textScaler: TextScaler.linear(0.75),
                              )));
                          }
                        },
                        child: const Text(
                          "YES",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: const Text(
                          "NO",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
                  ],
                )));
              },
            ),
          )
              .animate()
              .scale(duration: 1.5.seconds, curve: Curves.elasticOut)
              .fade(duration: 1.5.seconds),
        ],
      ),
    );
  }
}
