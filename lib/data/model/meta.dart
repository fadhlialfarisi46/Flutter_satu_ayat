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
