import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizz_app/services/auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/background2.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25),
              BlendMode.overlay), // You can adjust the fitting of the image.
        ),
      ),
      padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
      child: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return const Portrait();
          } else {
            return const Landscape();
          }
        },
      ),
    ));
  }
}

class Portrait extends StatelessWidget {
  const Portrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ImageIcon(
            AssetImage("assets/icon2.png"),
            size: 250,
            // shadows: <Shadow>[
            //   Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 20.0)
            // ],
          )
              .animate()
              .scale(duration: 1.5.seconds, curve: Curves.elasticOut)
              .fade(duration: 1.5.seconds)
              .shimmer(
                  color: Theme.of(context).primaryColorLight,
                  duration: 9.seconds,
                  delay: 3.seconds),
          // const Icon(
          //   FontAwesomeIcons.palette,
          //   size: 125,
          //   shadows: <Shadow>[
          //     Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 20.0)
          //   ],
          // )
          //     .animate()
          //     .scale(duration: 1.5.seconds, curve: Curves.elasticOut)
          //     .fade(duration: 1.5.seconds)
          //     .shimmer(
          //         color: Theme.of(context).primaryColorLight,
          //         duration: 9.seconds,
          //         delay: 3.seconds),
          const Text(
            '\'Easely\' Amused',
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: [
                Shadow(
                    color: Colors.black, offset: Offset(2, 2), blurRadius: 20)
              ],
              fontSize: 48,
              fontStyle: FontStyle.italic,
            ),
          )
              .animate()
              .blur(
                  duration: 2.seconds,
                  curve: Curves.bounceInOut,
                  begin: const Offset(8, 0),
                  end: const Offset(0, 0))
              .fade(duration: 3.seconds),
          const Text(
            'a \'brush\' up quiz on famous paintings and art from Europe!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          )
              .animate()
              .blur(
                  duration: 2.seconds,
                  curve: Curves.bounceInOut,
                  begin: const Offset(8, 0),
                  end: const Offset(0, 0))
              .fade(duration: 3.seconds),
          const SizedBox(height: 30),
          LoginButton(
            icon: FontAwesomeIcons.arrowRightToBracket,
            text: 'Continue as Guest',
            loginMethod: AuthService().anonLogin,
            color: Theme.of(context).shadowColor,
          ).animate().fade(curve: Curves.easeInCirc, duration: 3.seconds),
          LoginButton(
            text: 'Sign in with Google',
            icon: FontAwesomeIcons.google,
            color: Theme.of(context).shadowColor,
            loginMethod: AuthService().googleLogin,
          ).animate().fade(curve: Curves.easeInCirc, duration: 3.seconds),
          // .slideY(begin: 1, duration: 1.5.seconds, delay: 3.seconds),
        ],
      ),
    );
  }
}

class Landscape extends StatelessWidget {
  const Landscape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage("assets/icon2.png"),
              size: 175,
            )
                .animate()
                .scale(duration: 1.5.seconds, curve: Curves.elasticOut)
                .fade(duration: 1.5.seconds)
                .shimmer(
                    color: Theme.of(context).primaryColorLight,
                    duration: 9.seconds,
                    delay: 3.seconds),
            const SizedBox(width: 30),
            const Text(
              '\'Easely\' Amused',
              textAlign: TextAlign.center,
              style: TextStyle(
                shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(2, 2), blurRadius: 20)
                ],
                fontSize: 48,
                fontStyle: FontStyle.italic,
              ),
            )
                .animate()
                .blur(
                    duration: 2.seconds,
                    curve: Curves.bounceInOut,
                    begin: const Offset(8, 0),
                    end: const Offset(0, 0))
                .fade(duration: 3.seconds),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'a \'brush\' up quiz on famous paintings and art from Europe, in landscape mode!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        )
            .animate()
            .blur(
                duration: 2.seconds,
                curve: Curves.bounceInOut,
                begin: const Offset(8, 0),
                end: const Offset(0, 0))
            .fade(duration: 3.seconds),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LoginButton(
              icon: FontAwesomeIcons.arrowRightToBracket,
              text: 'Continue as Guest',
              loginMethod: AuthService().anonLogin,
              color: Theme.of(context).shadowColor,
            ).animate().fade(curve: Curves.easeInCirc, duration: 3.seconds),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: Theme.of(context).shadowColor,
              loginMethod: AuthService().googleLogin,
            ).animate().fade(curve: Curves.easeInCirc, duration: 3.seconds),
          ],
        ),
        // .slideY(begin: 1, duration: 1.5.seconds, delay: 3.seconds),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor: color.withOpacity(0.375),
      ),
      onPressed: () => loginMethod(),
      label: Text(
        text,
        style: TextStyle(color: Theme.of(context).primaryColorLight),
        textAlign: TextAlign.center,
        textScaler: const TextScaler.linear(1.5),
      ),
    );
  }
}
