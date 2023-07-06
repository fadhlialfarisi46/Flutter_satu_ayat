import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:satu_ayat/data/model/ayat.dart';

import '../widgets/custom_snackbar.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final Ayat ayat;

  const DetailPage({Key? key, required this.ayat}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-image.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0xFF3D3D3D),
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StackWidget(
                    ayat: widget.ayat,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _tafsirWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  _playAudioWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playAudioWidget() {
    return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      //color is transparent so that it does not blend with the actual color specified
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      color: const Color.fromRGBO(0, 0, 0,
                          0.5019607843137255) // Specifies the background color and the opacity
                      ),
                  child: Column(
                    children: [
                      const Text("Play Audio",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.ayat.audioList().length,
                        itemBuilder: (context, index) {
                          final audioItem = widget.ayat.audioList()[index];
                          return ElevatedButton(
                              onPressed: () {
                                audioPlayer.play(UrlSource(audioItem.urlMp3));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.play_circle_rounded),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(audioItem.qori)
                                  ],
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                );
  }

  Widget _tafsirWidget() {
    return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      //color is transparent so that it does not blend with the actual color specified
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      color: const Color.fromRGBO(0, 0, 0,
                          0.5019607843137255) // Specifies the background color and the opacity
                      ),
                  child: Column(
                    children: [
                      const Text("Tafsir",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(widget.ayat.tafsir?.kemenag.long ?? "",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
  }
}

class NoStackWidget extends StatelessWidget {
  const NoStackWidget({
    Key? key,
    required this.ayat,
  }) : super(key: key);

  final Ayat ayat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          //color is transparent so that it does not blend with the actual color specified
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          color: const Color.fromRGBO(0, 0, 0,
              0.5019607843137255) // Specifies the background color and the opacity
          ),
      child: Column(
        children: [
          Text(ayat.arab ?? "",
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold)),
          Text(ayat.translation ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  // fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 8,
          ),
          Text("[122:${ayat.number?.inSurah}]",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  // fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class StackWidget extends StatelessWidget {
  const StackWidget({
    Key? key,
    required this.ayat,
  }) : super(key: key);

  final Ayat ayat;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    //color is transparent so that it does not blend with the actual color specified
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    color: const Color.fromRGBO(0, 0, 0,
                        0.5019607843137255) // Specifies the background color and the opacity
                    ),
                child: Column(
                  children: [
                    Text(ayat.arab ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                    Text(ayat.translation ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            // fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text("[122:${ayat.number?.inSurah}]",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            // fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
          Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    customSnackbar(context);
                  },
                  child: const Icon(Icons.favorite),
                ),
              )),
        ],
      ),
    );
  }
}
