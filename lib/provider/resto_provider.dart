import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/result_state.dart';

import '../api/api_service.dart';

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    fetchRestoFull();
  }

  late RestoList _resto;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestoList get result => _resto;

  ResultState get state => _state;

  Future<dynamic> fetchRestoFull() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _resto = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Oops. Koneksi internet kamu mati!';
    }
  }
}
