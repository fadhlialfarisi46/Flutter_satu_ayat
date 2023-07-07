import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/model/ayat.dart';

class PlayAudioWidget extends StatelessWidget {

  PlayAudioWidget({
    Key? key,
    required this.ayat,
  }) : super(key: key);

  final Ayat ayat;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
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
            itemCount: ayat.audioList().length,
            itemBuilder: (context, index) {
              final audioItem = ayat.audioList()[index];
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
}
