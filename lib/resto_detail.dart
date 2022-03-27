import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/main_page.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/styles.dart';
import 'package:yess_nutrion/widget/drink_list.dart';
import 'package:yess_nutrion/widget/food_list.dart';

class DetailResto extends StatefulWidget {
  static const routeName = 'detail/restaurant';
  final String id;

  const DetailResto({required this.id});

  @override
  State<DetailResto> createState() => _DetailRestoState();
}

class _DetailRestoState extends State<DetailResto> {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
        create: (_) => RestoProvider(
            apiService: ApiService(), type: 'detail', id: widget.id),
        child: Scaffold(
            body: Consumer<RestoProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            final resto = state.result;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/medium/' +
                                          resto.restaurant.pictureId),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, RecomendResto.routeName);
                                      },
                                    ),
                                  ]),
                              SizedBox(
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resto.restaurant.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(resto.restaurant.city)
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(resto.restaurant.description),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Foods',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              FoodList(foods: resto.restaurant.menus.foods),
                              SizedBox(height: 30),
                              Text(
                                'Drinks',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              DrinkList(drinks: resto.restaurant.menus.drinks),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        })));
  }
}
