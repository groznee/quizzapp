import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/quiz/quiz_state.dart';
import 'package:quizz_app/services/firestore.dart';
import 'package:quizz_app/services/models.dart';
import 'package:quizz_app/shared/loading.dart';
import 'package:quizz_app/shared/progress_bar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:photo_view/photo_view.dart';

part 'quiz_question_page.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizId, required this.quizTitle});
  final String quizId;
  final String quizTitle;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return const LoadingScreen();
          } else {
            var quiz = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                elevation: 8,
                toolbarHeight: 32,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    icon: const Icon(
                      FontAwesomeIcons.xmark,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
                leading: null,
                automaticallyImplyLeading: false,
                title: AnimatedProgressbar(value: state.progress),
                // centerTitle: true,
                // titleSpacing: 0.0,
              ),
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: state.controller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz);
                  } else if (idx == quiz.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/background4.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withOpacity(0.75),
              BlendMode.color),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headlineMedium),
          const Divider(height: 50),
          Expanded(
              child: Text(
            quiz.description,
            style: Theme.of(context).textTheme.headlineSmall,
          )),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: state.nextPage,
                label: const Text('Start Quiz!'),
                icon: const Icon(Icons.start),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runAlignment: WrapAlignment.spaceEvenly,
        spacing: 25,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Congratulations art lover! You completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          const Divider(height: 25),
          Image.asset('assets/congrats.gif'),
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorLight,
            ),
            icon: const Icon(FontAwesomeIcons.check),
            label: const Text('Mark Complete!'),
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
