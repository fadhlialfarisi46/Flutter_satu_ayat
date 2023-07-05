
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:satu_ayat/data/api/api_service.dart';
import 'package:satu_ayat/data/model/ayat.dart';

import '../extension/state_management.dart';

class DetailAyatProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailAyatProvider({required this.apiService}) {
    fetchAyat();
  }

  late Ayat _detailAyatResult;
  Ayat get result => _detailAyatResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchAyat() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getDetailAyat();
      // if (result.error) {
      //   _state = ResultState.noData;
      //   notifyListeners();
      //   return _message = 'Failed to load data';
      // } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailAyatResult = result;
      // }
    }on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
      'No internet connection. Make sure your Wi-Fi or mobile data is turned on, then try again.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}