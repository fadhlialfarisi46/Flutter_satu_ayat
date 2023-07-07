import 'package:flutter/material.dart';

import '../data/model/ayat.dart';
import 'custom_snackbar.dart';

class StackAyatWidget extends StatelessWidget {
  const StackAyatWidget({
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