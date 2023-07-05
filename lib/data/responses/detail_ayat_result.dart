import 'package:satu_ayat/data/model/ayat.dart';

class DetailAyatResult {
  DetailAyatResult({
    // required this.error,
    // required this.message,
    required this.ayat,
  });
  //
  // bool error;
  // String message;
  Ayat ayat;

  factory DetailAyatResult.fromJson(Map<String, dynamic> json) =>
      DetailAyatResult(
        // error: json["error"],
        // message: json["message"],
        ayat: Ayat.fromJson(json[""]),
      );
}