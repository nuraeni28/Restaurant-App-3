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
          Consumer<DatabaseProvider>(builder: (context, result, child) {
            if (result.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (result.state == ResultState.HasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: result.favorites.length,
                  itemBuilder: (context, index) {
                    var resto = result.favorites[index];
                    return ListResto(resto: resto);
                  });
            } else if (result.state == ResultState.NoData) {
              return Center(
                child: Text('No Favorite Restaurant'),
              );
            } else if (result.state == ResultState.Error) {
              return Center(child: Text('Oops. Koneksi internet kamu mati!'));
            } else {
              return Container();
            }
          })
        ],
      ))
    ]));
  }
// }
}
