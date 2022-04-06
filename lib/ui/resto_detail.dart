import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/common//styles.dart';
import 'package:yess_nutrion/db/database_helper.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/provider/database_provider.dart';
import 'package:yess_nutrion/provider/detail_provider.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/result_state.dart';
import 'package:yess_nutrion/ui/main_page.dart';
import 'package:yess_nutrion/widget/drink_list.dart';
import 'package:yess_nutrion/widget/food_list.dart';
import 'package:yess_nutrion/widget/nav_bar.dart';

class DetailResto extends StatelessWidget {
  static const routeName = 'detail/restaurant';
  final Restaurant resto;

  const DetailResto({required this.resto});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoDetailProvider>(
          create: (_) =>
              RestoDetailProvider(apiService: ApiService(), id: resto.id),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Scaffold(
        body: _builder(context),
      ),
    );
  }

  Widget _builder(context) {
    return Consumer<RestoDetailProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        final value = state.detailRestaurant;
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
                                      value.restaurant.pictureId),
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
                                        context, MainPage.routeName);
                                  },
                                ),
                              ]),
                          SizedBox(
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Consumer<DatabaseProvider>(
                                builder: (context, favorite, child) {
                                  return FutureBuilder<bool>(
                                    future: favorite.isFavorited(resto.id),
                                    builder: (context, snapshot) {
                                      var isFavorited = snapshot.data ?? false;
                                      return Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: isFavorited
                                              ? IconButton(
                                                  icon: const Icon(
                                                      Icons.favorite),
                                                  color: Colors.redAccent,
                                                  onPressed: () => favorite
                                                      .removeFavorite(resto.id),
                                                )
                                              : IconButton(
                                                  icon: const Icon(
                                                      Icons.favorite_border),
                                                  color: Colors.redAccent,
                                                  onPressed: () => favorite
                                                      .addFavorite(resto),
                                                )
                                          // child: Center(child: LoveButton()),
                                          );
                                    },
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.restaurant.name,
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
                              Text(value.restaurant.city)
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
                          Text(value.restaurant.description),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Foods',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          FoodList(foods: value.restaurant.menus.foods),
                          SizedBox(height: 30),
                          Text(
                            'Drinks',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          DrinkList(drinks: value.restaurant.menus.drinks),
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
    });
  }
}
