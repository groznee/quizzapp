import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl = "";

  @override
  void initState() {
    super.initState();
    loadImageUrl();
  }

  Future<void> loadImageUrl() async {
    final Reference imageRef = storage.ref().child("about.jpg");
    final String url = await imageRef.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
              child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(shadows: [
                        Shadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            blurRadius: 7.5,
                            offset: const Offset(2.5, 2.5))
                      ]),
                      children: const <InlineSpan>[
                    TextSpan(text: "This free app was created to learn "),
                    TextSpan(
                        text: "Flutter and Firebase",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            ", expanding on a Fireship tutorial, and to explore "),
                    TextSpan(
                        text: "responsive design",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            "  (this app features a landscape mode)...\n\n... and to learn a bit about  "),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.top,
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(" ART! \u200B", //zero braking space
                              textScaler: TextScaler.linear(2),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white,
                                  color: Colors.black))),
                    ),
                    // TextSpan(
                    //     text: "art.",
                    //     style: TextStyle(
                    //         backgroundColor: Colors.white,
                    //         color: Colors.black))
                  ]))),
          imageUrl.isEmpty
              // SizedBox here to keep the layout stable while image loads
              ? SizedBox(height: MediaQuery.of(context).size.height / 2)
              : FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, // Empty placeholder
                  image: imageUrl, // Image from network
                  fit: BoxFit.contain, // Adjust the fit as needed
                  // width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                ),
        ],
      ),
    );
  }
}
