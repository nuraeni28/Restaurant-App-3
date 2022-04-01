import 'package:flutter/material.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  String id;

  RestoDetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant();
  }

  late RestoDetail _restaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  RestoDetail get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resto = await apiService.restaurantDetail(id);
      if (resto.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
