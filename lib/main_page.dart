import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/resto_page.dart';
import 'package:yess_nutrion/resto_search.dart';
import 'package:yess_nutrion/widget/resto_list.dart';

import 'api/api_service.dart';

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
        create: (_) =>
            RestoProvider(apiService: ApiService(), type: 'list', id: ''),
        child: RestoPage());
  }
}
