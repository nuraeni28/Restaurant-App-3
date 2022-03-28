import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import '../api/api_service.dart';

enum SearchState { Loading, NoData, HasData, Error, NoQueri }

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;

  // final String query;

  SearchRestoProvider({required this.apiService}) {
    fetcSearchResto();
  }

  late RestoSearch _searchResult;
  late SearchState _state;
  String _message = '';
  String query = '';

  String get message => _message;
  RestoSearch get result => _searchResult;
  SearchState get state => _state;

  Future<dynamic> fetcSearchResto() async {
    if (query != "") {
      try {
        _state = SearchState.Loading;
        final search = await apiService.searchRestaurant(query);
        if (search.restaurants.isEmpty) {
          _state = SearchState.NoData;
          notifyListeners();
          return _message = 'Restaurant yang Anda cari tidak ditemukan';
        } else {
          _state = SearchState.HasData;
          notifyListeners();
          return _searchResult = search;
        }
      } catch (e) {
        _state = SearchState.Error;
        notifyListeners();
        return _message = 'Whoops. Kamu tidak tersambung dengan Internet!';
      }
    } else {
      _state = SearchState.NoQueri;
      notifyListeners();
      return _message = 'No queri';
    }
  }

  void addQueri(String query) {
    this.query = query;
    fetcSearchResto();
    notifyListeners();
  }
}
