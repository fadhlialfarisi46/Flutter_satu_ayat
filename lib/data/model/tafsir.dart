import 'kemenag.dart';

class Tafsir {
  Kemenag kemenag;
  String quraish;
  String jalalayn;

  Tafsir({
    required this.kemenag,
    required this.quraish,
    required this.jalalayn,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
    kemenag: Kemenag.fromJson(json["kemenag"]),
    quraish: json["quraish"],
    jalalayn: json["jalalayn"],
  );

  Map<String, dynamic> toJson() => {
    "kemenag": kemenag.toJson(),
    "quraish": quraish,
    "jalalayn": jalalayn,
  };
}
