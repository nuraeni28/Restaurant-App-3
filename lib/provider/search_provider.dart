import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/resto_search.dart';
import '../api/api_service.dart';

enum SearchState { Loading, NoData, HasData, Error }

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;
  // final String query;

  SearchRestoProvider({required this.apiService}) {
    fetcSearchResto(query);
  }

  RestoSearch? _searchResult;
  SearchState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  RestoSearch? get result => _searchResult;
  SearchState? get state => _state;
  String get query => _query;

  Future<dynamic> fetcSearchResto(String query) async {
    try {
      _state = SearchState.Loading;
      _query = query;
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
  }
}
