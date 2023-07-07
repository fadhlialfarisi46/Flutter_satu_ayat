import 'package:satu_ayat/data/model/tafsir.dart';
import 'package:satu_ayat/data/model/tafsir_list.dart';
import 'package:satu_ayat/data/model/url_audio.dart';

import 'audio.dart';
import 'meta.dart';
import 'number.dart';

class Ayat {
  Number? number;
  String? arab;
  String? translation;
  Meta? meta;
  Audio? audio;
  Tafsir? tafsir;

  Ayat({
    this.number,
    this.arab,
    this.translation,
    this.meta,
    this.audio,
    this.tafsir,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        number: Number.fromJson(json["number"]),
        arab: json["arab"],
        translation: json["translation"],
        meta: Meta.fromJson(json["meta"]),
        audio: Audio.fromJson(json["audio"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number?.toJson(),
        "arab": arab,
        "translation": translation,
        "tafsir": tafsir?.toJson(),
        "meta": meta?.toJson(),
      };

  bool isAyatNull() =>
      (arab == null && number == null && translation == null && audio == null);

  List<UrlAudio> audioList() => [
        UrlAudio("Alafasy", audio!.alafasy),
        UrlAudio("Ahmed Ajamy", audio!.ahmedajamy),
        UrlAudio("Husary Mujawwad", audio!.husarymujawwad),
        UrlAudio("Minshawi", audio!.minshawi),
        UrlAudio("Muhammad Ayyoub", audio!.muhammadayyoub),
        UrlAudio("Muhammad Jibreel", audio!.muhammadjibreel),
      ];

  List<TafsirList> tafsirList() => [
    TafsirList(from: "Kemenag", content: tafsir!.kemenag.short),
    TafsirList(from: "Quraish", content: tafsir!.quraish),
    TafsirList(from: "Jalalayn", content: tafsir!.jalalayn),
  ];
}