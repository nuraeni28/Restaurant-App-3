import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';

import '../api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;
  final String type;
  final String id;

  RestoProvider(
      {required this.apiService, required this.type, required this.id}) {
    if (type == 'list') {
      fetchRestoFull();
    } else if (type == 'detail') {
      // fetchRestoDetail(id);
    }
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
      return _message = 'Error';
    }
  }

  // Future<dynamic> fetchRestoDetail(String id) async {
  //   try {
  //     _state = ResultState.Loading;
  //     notifyListeners();
  //     final restaurantDetail = await apiService.restaurantDetail(id);
  //     _state = ResultState.HasData;
  //     notifyListeners();
  //     return _resto = restaurantDetail;
  //   } catch (e) {
  //     _state = ResultState.Error;
  //     notifyListeners();
  //     return _message = 'Error --> $e';
  //   }
  // }
}
