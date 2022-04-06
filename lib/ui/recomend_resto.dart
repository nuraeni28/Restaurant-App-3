import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/ui/resto_page.dart';

class RecomendResto extends StatefulWidget {
  static const routeName = '/resto_recomend';

  @override
  State<RecomendResto> createState() => _RecomendRestoState();
}

class _RecomendRestoState extends State<RecomendResto> {
  // late Future<RestoList> _resto;
  // // late RestoProvider provider;

  // @override
  // void initState() {
  //   super.initState();
  //   _resto = ApiService().restaurantList();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RestoProvider(
              apiService: ApiService(),
            ),
        child: RestoPage());
  }
}
