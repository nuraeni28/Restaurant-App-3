import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/common/styles.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/provider/database_provider.dart';
import 'package:yess_nutrion/result_state.dart';
import 'package:yess_nutrion/ui/resto_detail.dart';
import 'package:yess_nutrion/widget/resto_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const routeName = '/resto_favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoriteBody(),
    );
  }
}

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 30),
                  child: Text(
                    'Favorite Restaurant ',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 30),
                  child: Text(
                    'List your favorite restaurant',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Consumer<DatabaseProvider>(builder: (context, favorite, _) {
            if (favorite.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (favorite.state == ResultState.HasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: favorite.favorites.length,
                  itemBuilder: (context, index) {
                    return FavoriteData(resto: favorite.favorites[index]);
                  });
            } else if (favorite.state == ResultState.NoData) {
              return Center(
                child: Text('No Favorite Restaurant'),
              );
            } else if (favorite.state == ResultState.Error) {
              return Center(child: Text('Oops. Koneksi internet kamu mati!'));
            } else {
              return Container();
            }
          })
        ],
      ))
    ]));
  }
}

class FavoriteData extends StatelessWidget {
  final Restaurant resto;

  const FavoriteData({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(resto.id),
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(builder: (_) => DetailResto(resto: resto)),
                )
                    .then((_) {
                  context.read<DatabaseProvider>().getFavorites();
                });
              },
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          margin: EdgeInsets.only(left: 40, bottom: 20),
                          child: Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                    tag: resto,
                                    child: Image.network(
                                      "https://restaurant-api.dicoding.dev/images/medium/" +
                                          resto.pictureId,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ))),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white70),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resto.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    resto.city,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(resto.rating.toString())
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            );
          },
        );
      },
    );
  }
}
