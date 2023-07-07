import 'package:flutter/material.dart';
import 'package:satu_ayat/data/model/ayat.dart';

import '../widgets/play_audio_widget.dart';
import '../widgets/stack_ayat_widget.dart';
import '../widgets/tafsir_widget.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final Ayat ayat;

  const DetailPage({Key? key, required this.ayat}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StackAyatWidget(
                    ayat: widget.ayat,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TafsirWidget(tafsirList: widget.ayat.tafsirList()),
                  const SizedBox(
                    height: 16,
                  ),
                  PlayAudioWidget(
                    ayat: widget.ayat,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
