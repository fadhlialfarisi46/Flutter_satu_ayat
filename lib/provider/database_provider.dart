import 'package:flutter/cupertino.dart';
import 'package:satu_ayat/data/model/ayat.dart';

import '../data/db/db_helper.dart';
import '../extension/state_management.dart';

class DatabaseProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DatabaseProvider({required this.dbHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Ayat> _favorites = [];
  List<Ayat> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultState.loading;
    notifyListeners();

    _favorites = await dbHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.noData;
      _message = "Empty data";
      notifyListeners();
    }
  }

  void addFavorite(Ayat ayat) async {
    try {
      await dbHelper.insertFavorite(ayat);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedAyat = await dbHelper.getFavoriteById(id);
    return favoritedAyat.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await dbHelper.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}
