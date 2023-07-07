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

class Number {
  int inQuran;
  int inSurah;

  Number({
    required this.inQuran,
    required this.inSurah,
  });

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Meta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;

  Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
      };
}

class Audio {
  String alafasy;
  String ahmedajamy;
  String husarymujawwad;
  String minshawi;
  String muhammadayyoub;
  String muhammadjibreel;

  Audio({
    required this.alafasy,
    required this.ahmedajamy,
    required this.husarymujawwad,
    required this.minshawi,
    required this.muhammadayyoub,
    required this.muhammadjibreel,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        alafasy: json["alafasy"],
        ahmedajamy: json["ahmedajamy"],
        husarymujawwad: json["husarymujawwad"],
        minshawi: json["minshawi"],
        muhammadayyoub: json["muhammadayyoub"],
        muhammadjibreel: json["muhammadjibreel"],
      );

  Map<String, dynamic> toJson() => {
        "alafasy": alafasy,
        "ahmedajamy": ahmedajamy,
        "husarymujawwad": husarymujawwad,
        "minshawi": minshawi,
        "muhammadayyoub": muhammadayyoub,
        "muhammadjibreel": muhammadjibreel,
      };
}

class UrlAudio {
  String qori;
  String urlMp3;

  UrlAudio(this.qori, this.urlMp3);
}

class TafsirList {
  String from;
  String content;
  bool isExpanded;

  TafsirList({required this.from, required this.content, this.isExpanded = false});
}

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

class Kemenag {
  String short;
  String long;

  Kemenag({
    required this.short,
    required this.long,
  });

  factory Kemenag.fromJson(Map<String, dynamic> json) => Kemenag(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}
