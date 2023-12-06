import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/quiz/quiz.dart';
import 'package:quizz_app/services/models.dart';

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: topic.quizzes.map(
        (quiz) {
          return Card(
            color: Theme.of(context).shadowColor.withOpacity(0.75),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            // borderRadius: BorderRadius.all(Radius.elliptical(16, 16))),
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        QuizScreen(quizId: quiz.id, quizTitle: quiz.title),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: ListTile(
                  dense: false,
                  contentPadding: const EdgeInsets.all(8),
                  title: Text(quiz.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  subtitle: Text(quiz.description,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                  leading: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuizBadge(topic: topic, quizId: quiz.id),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;

  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return Icon(
        Icons.task_alt,
        color: Theme.of(context).primaryColorLight,
        size: 24,
      );
    } else {
      return Icon(
        Icons.circle_outlined,
        color: Theme.of(context).primaryColorLight,
        size: 24,
      );
    }
  }
}
