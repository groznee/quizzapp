import 'package:flutter/material.dart';
import 'package:quizz_app/services/models.dart';
import 'package:quizz_app/shared/progress_bar.dart';
import 'package:quizz_app/topics/topic_lists.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => TopicScreen(topic: topic),
            ),
          );
        },
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double parentWidth = constraints.maxWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 48,
                child: Hero(
                  tag: topic.img,
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/covers/${topic.img}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Hero(
                  tag: topic.title,
                  child: Text(
                    topic.title,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(height: 1.5, fontSize: parentWidth * 0.069),
                    // style: TextStyle(
                    //   fontSize: parentWidth * 0.069, // 0.069, my lucky number
                    // ),
                  ),
                ),
              ),
              Flexible(flex: 12, child: TopicProgress(topic: topic)),
            ],
          );
        }),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return PortraitQuizList(topic: topic);
          } else {
            return LandscapeQuizList(topic: topic);
          }
        },
      ),
    );
  }
}

class LandscapeQuizList extends StatelessWidget {
  const LandscapeQuizList({
    super.key,
    required this.topic,
  });

  final Topic topic;

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: topic.img,
                child: Image.asset('assets/covers/${topic.img}',
                    width: MediaQuery.of(context).size.width / 2),
              ),
              Hero(
                tag: topic.title,
                child: Text(
                    textAlign: TextAlign.center,
                    topic.title,
                    style: Theme.of(context).textTheme.headlineMedium),
              )
            ],
          ),
          Expanded(
            child: QuizList(topic: topic),
          )
        ],
      ),
    );
  }
}

class PortraitQuizList extends StatelessWidget {
  const PortraitQuizList({
    super.key,
    required this.topic,
  });

  final Topic topic;

  @override
  Widget build(BuildContext context) {
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
      child: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Hero(
          tag: topic.title,
          child: Text(
              textAlign: TextAlign.center,
              topic.title,
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        QuizList(topic: topic)
      ]),
    );
  }
}
