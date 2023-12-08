import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizz_app/services/services.dart';
import 'package:quizz_app/shared/shared.dart';
import 'package:quizz_app/topics/drawer.dart';
import 'package:quizz_app/topics/topic_item.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool wantListView = true; //true for list, false for grid layout widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return OrientationBuilder(builder: (context, orientation) {
            //there are some visual bugs present with wider screens in portrait
            //mode, for which this is a hacky maths fix
            double aspectRatio = MediaQuery.of(context).size.aspectRatio;
            double itemExtentio = MediaQuery.of(context).size.height / 3;
            EdgeInsets itemPaddingio =
                const EdgeInsets.fromLTRB(25, 20, 25, 10);
            if (aspectRatio > 0.626) {
              itemPaddingio -= const EdgeInsets.only(top: 10);
              itemPaddingio *= 3.5 / aspectRatio;
              itemExtentio *= 0.75 / aspectRatio;
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Topics'),
                actions: [
                  if (orientation == Orientation.portrait)
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.list,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () => setState(() {
                        wantListView = !wantListView;
                      }),
                    )
                ],
              ),
              drawer: ThemeDrawer(topics: topics),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage("assets/background1.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor.withOpacity(0.75),
                        BlendMode.color),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (orientation == Orientation.landscape)
                      const LeftNavRail(),
                    Expanded(
                      child: (wantListView &&
                              (orientation != Orientation.landscape))
                          ? ListView(
                              itemExtent: itemExtentio,
                              // padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                              padding: itemPaddingio,
                              children: topics
                                  .map((topic) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: TopicItem(topic: topic),
                                      ))
                                  .toList(),
                            )
                          : GridView.count(
                              primary: true,
                              padding: const EdgeInsets.all(10.0),
                              childAspectRatio: 1.25,
                              crossAxisCount: 2,
                              children: topics
                                  .map((topic) => TopicItem(topic: topic))
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: (orientation == Orientation.portrait)
                  ? const BottomNavBar()
                  : null,
            );
          });
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
