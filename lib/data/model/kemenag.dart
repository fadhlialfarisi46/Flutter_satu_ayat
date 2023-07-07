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
