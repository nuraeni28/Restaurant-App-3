import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/widget/resto_list.dart';

import 'api/api_service.dart';

class RecomendResto extends StatefulWidget {
  static const routeName = '/resto_recomend';

  @override
  State<RecomendResto> createState() => _RecomendRestoState();
}

class _RecomendRestoState extends State<RecomendResto> {
  late Future<RestoList> _resto;
  // late RestoProvider provider;

  @override
  void initState() {
    super.initState();
    _resto = ApiService().restaurantList();
  }

  @override
  Widget build(BuildContext context) {
    RestoProvider _provider;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 16,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.location_on,
            size: 24,
            color: Color(0xff00b894),
          ),
          onPressed: () {},
        ),
        // titleSpacing: 0,
        title: Text(
          "Hartaco Indah",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5, top: 5),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/muslimah.png'),
              backgroundColor: Color(0xff00b894),
              radius: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 25, right: 25),
                    child: Text(
                      'What is your ',
                      style: TextStyle(
                          fontSize: 32,
                          letterSpacing: 2,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 10, right: 25),
                    child: Text(
                      'Favorite Restaurant? ',
                      style: TextStyle(
                          color: Color(0xff00b894),
                          fontSize: 28,
                          letterSpacing: 2,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.green.withOpacity(0.2)),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: 'Search'),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 0),
                    child: Text(
                      'Restaurant ',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 60),
                    child: Text(
                      'Recommendation restaurant for you!',
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
            SizedBox(
              height: 10,
            ),
            // ChangeNotifierProvider<RestoProvider>(
            //     create: (_) => RestoProvider(
            //         apiService: ApiService(), type: 'list', id: ''),
            //     child: Consumer<RestoProvider>(builder: (context, state, _) {
            //       _provider = state;
            //       final result = state.result as RestoList;
            //       if (state.state == ResultState.Loading) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (state.state == ResultState.HasData) {
            //         return ListView.builder(
            //           itemCount: result.restaurants.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             var resto = result.restaurants[index];
            //             return ListResto(resto: resto);
            //           },
            //         );
            //       }
            //       return Container();
            //     })),
            Expanded(
              child: FutureBuilder(
                future: _resto,
                builder: (context, AsyncSnapshot<RestoList> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Gagal menampilkan data");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.restaurants.length,
                        itemBuilder: (context, index) {
                          var resto = snapshot.data?.restaurants[index];
                          return ListResto(
                            resto: resto!,
                          );
                        });
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      // padding: EdgeInsets.only(top: 15, left: 30),
    );
  }

  // Widget _buildRestaurantItem(BuildContext context, Resto resto) {
  //   return ListResto(
  //     resto: resto,
  //   );
  // }
}
