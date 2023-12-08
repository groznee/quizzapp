part of "quiz.dart";

class ZoomableImageScreen extends StatelessWidget {
  final String imageUrl;

  const ZoomableImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // elevation: 8,
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          padding: const EdgeInsets.only(bottom: 0),
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoView(
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 2,
              imageProvider: NetworkImage(imageUrl),
              heroAttributes:
                  const PhotoViewHeroAttributes(tag: "questionHero"),
            ),
            const Positioned(
              bottom: 10,
              right: 10,
              child: Text("Double tap or pinch to zoom, tap to close",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      backgroundColor: Color.fromARGB(64, 0, 0, 0))),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;

  const QuestionPage({super.key, required this.question});

  Future<String> fetchImageUrl() async {
    Reference imageRef = FirebaseStorage.instance.ref().child(question.image);
    final String imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }

  void openPhotoView(context, url) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZoomableImageScreen(imageUrl: url),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portraitQuestionPage(state, context);
        } else {
          return landscapeQuestionPage(state, context);
        }
      },
    );
  }

  Row landscapeQuestionPage(QuizState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
                FutureBuilder<String>(
                    future: fetchImageUrl(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                            "Error loading image, use your imagination.");
                      } else if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            openPhotoView(context, snapshot.data!);
                          },
                          onScaleUpdate: (details) {
                            if (details.scale > 1.5) {
                              openPhotoView(context, snapshot.data!);
                            }
                          },
                          child: Center(
                            child: Hero(
                              tag: "questionHero",
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snapshot.data!,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width / 2,
                                  fadeInDuration:
                                      const Duration(milliseconds: 300)),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width / 2);
                      }
                    })),
                const Positioned(
                  bottom: 10,
                  right: 50,
                  child: Text("Tap or pinch to open",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          backgroundColor: Color.fromARGB(64, 0, 0, 0))),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DynamicTextScaleWidget(text: question.text),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: question.options.map((opt) {
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 4),
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.25),
                      child: InkWell(
                        onTap: () {
                          state.selected = opt;
                          _bottomSheet(context, opt, state);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                  state.selected == opt
                                      ? FontAwesomeIcons.circleDot
                                      : FontAwesomeIcons.circle,
                                  size: 22),
                              Container(
                                margin: const EdgeInsets.only(left: 16),
                                child: Text(
                                  overflow: TextOverflow.fade,
                                  opt.value,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column portraitQuestionPage(QuizState state, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                    FutureBuilder<String>(
                        future: fetchImageUrl(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                                "Error loading image, use your imagination.");
                          } else if (snapshot.hasData) {
                            return GestureDetector(
                              onTap: () {
                                openPhotoView(context, snapshot.data!);
                              },
                              onScaleUpdate: (details) {
                                if (details.scale > 1.5) {
                                  openPhotoView(context, snapshot.data!);
                                }
                              },
                              child: Center(
                                child: Hero(
                                  tag: "questionHero",
                                  child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: snapshot.data!,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      fadeInDuration:
                                          const Duration(milliseconds: 300)),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                                height: MediaQuery.of(context).size.height / 2);
                          }
                        })),
                    const Positioned(
                      bottom: 10,
                      right: 10,
                      child: Text("Tap or pinch to open",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              backgroundColor: Color.fromARGB(64, 0, 0, 0))),
                    ),
                  ],
                ),
                const SizedBox(height: 16), //could wrap Text in padding as well
                Expanded(
                  flex: 1,
                  child: DynamicTextScaleWidget(text: question.text),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: question.options.map((opt) {
              return Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 4),
                color: Theme.of(context).primaryColorDark.withOpacity(0.25),
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 32),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.circleDot
                                : FontAwesomeIcons.circle,
                            size: 22),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Text(
                            opt.value,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColorLight),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: correct ? Colors.green : Colors.red),
                child: Text(
                  correct ? 'Onward!' : 'Try Again',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class DynamicTextScaleWidget extends StatelessWidget {
  const DynamicTextScaleWidget({
    super.key,
    required this.text,
  });

  final String text;

  double calculateScaler() {
    if (text.length > 175) {
      return (1.2 * (175 / text.length)).clamp(1, 1.2);
    } else {
      return 1.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textScaler: TextScaler.linear(calculateScaler()),
        overflow: TextOverflow.fade);
  }
}
