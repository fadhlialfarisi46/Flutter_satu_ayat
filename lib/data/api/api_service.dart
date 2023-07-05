import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../model/ayat.dart';

class ApiService {
  static const String baseUrl = 'https://quran-api-id.vercel.app';

  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

  Future<Ayat> getDetailAyat() async {
    //surahs/112/ayahs/2
    // final response = await client!.get(Uri.parse('$baseUrl/surahs/2/ayahs/255'));
    final response = await client!.get(Uri.parse('$baseUrl/random'));
    if (response.statusCode == 200) {
      return Ayat.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load one ayat');
    }
  }
}