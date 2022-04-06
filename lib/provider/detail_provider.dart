import 'package:flutter/material.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestoDetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant(id);
  }

  RestoDetail? _detailRestaurant;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  RestoDetail get detailRestaurant => _detailRestaurant!;

  ResultState get state => _state!;

  Future<dynamic> _fetchAllDetailRestaurant(String id) async {
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
        return _detailRestaurant = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
