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
