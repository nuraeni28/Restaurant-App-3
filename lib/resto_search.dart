import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/provider/search_provider.dart';
import 'package:yess_nutrion/resto_page.dart';
import 'package:yess_nutrion/styles.dart';
import 'package:yess_nutrion/widget/resto_list.dart';

class SearchResto extends StatelessWidget {
  const SearchResto({Key? key}) : super(key: key);
  static const routeName = '/resto_search';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestoProvider>(
      create: (_) => SearchRestoProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BodySearch(),
      ),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchRestoProvider>(context, listen: false);
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
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Search ',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 120),
                    child: Text(
                      'Find your favorite restaurant!',
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
            // Padding(
            //   padding: EdgeInsets.only(top: 15, left: 25, right: 25),
            //   child: Text(
            //     'Search ',
            //     style: TextStyle(
            //         fontSize: 24,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 25, bottom: 10, right: 25),
            //   child: Text(
            //     'Find Your Favorite Restaurant!',
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black54),
            //   ),
            // )
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
                    hintText: 'Search',
                    filled: true),
                onSubmitted: (value) {
                  search.addQueri(value);
                },
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Consumer<SearchRestoProvider>(
        builder: (context, result, _) {
          if (result.state == SearchState.NoQueri) {
            return (Center(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 100,
                      color: secondaryColor,
                    ),
                    Text("Come on!, Search Your Favorite Restaurant")
                  ],
                ),
              ),
            ));
          } else if (result.state == SearchState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (result.state == SearchState.HasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: result.result.restaurants.length,
                itemBuilder: (context, index) {
                  var resto = result.result.restaurants[index];
                  return ListResto(
                    resto: resto,
                  );
                },
              ),
            );
          } else if (result.state == SearchState.NoData) {
            return Center(
              child: Text('No list restaurant you want'),
            );
          } else if (result.state == SearchState.Error) {
            return Center(
              child: Text("Whoops. Kamu tidak tersambung dengan Internet!"),
            );
          } else {
            return Center(child: const Text(''));
          }
        },
      ),
    ]));
  }
}
// class SearchResto extends StatefulWidget {

//   @override
//   State<SearchResto> createState() => _SearchRestoState()
//;child :
// }

// class _SearchRestoState extends State<SearchResto> {
//   // String _queries = '';

//   // Widget _buildResto(BuildContext context) {
//   //   return Consumer<SearchRestoProvider>(builder: (context, state, _) {
//   //     if (state.state == SearchState.Loading) {
//   //       return Center(
//   //           child: Container(
//   //         child: Text('Cari Restoran mu'),
//   //       ));
//   //     } else if (state.state == SearchState.HasData) {
//   //       // state.fetchSearchRestaurant(queries);
//   //       return ListView.builder(
//   //           shrinkWrap: true,
//   //           itemCount: state.result!.restaurants.length,
//   //           itemBuilder: (context, index) {
//   //             var resto = state.result!.restaurants[index];
//   //             return ListResto(resto: resto);
//   //           });
//   //     } else if (state.state == SearchState.NoData) {
//   //       return Text(state.message);
//   //     } else if (state.state == SearchState.Error) {
//   //       return (Text(state.message));
//   //     } else {
//   //       return Center(
//   //         child: Text(''),
//   //       );
//   //     }
//   //   }

//   //       // ignore: dead_code
//   //       );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final searchProvider =
//     //     Provider.of<SearchRestoProvider>(context, listen: false);
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//                 size: 24.0,
//               ),
//             ),
//             SizedBox(
//               height: 14,
//             ),
//             // Column(
//             //   crossAxisAlignment: CrossAxisAlignment.start,
//             //   mainAxisSize: MainAxisSize.max,
//             //   children: [
//             //     Text(
//             //       'Search',
//             //       style: Theme.of(context).textTheme.headline5,
//             //     ),
//             //     const SizedBox(
//             //       height: 6,
//             //     ),
//             //     Text(
//             //       'Find your favorite restaurant',
//             //       style: Theme.of(context).textTheme.subtitle1,
//             //     ),
//             //     const SizedBox(
//             //       height: 20.0,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         Expanded(
//             //           child: TextField(
//             //             cursorColor: secondaryColor,
//             //             decoration: InputDecoration(
//             //               border: OutlineInputBorder(
//             //                 borderRadius: BorderRadius.circular(30),
//             //                 borderSide: BorderSide.none,
//             //               ),
//             //               filled: true,
//             //               contentPadding: const EdgeInsets.symmetric(),
//             //               prefixIcon: const Icon(
//             //                 Icons.search,
//             //                 // color: secondaryColor,
//             //                 size: 22,
//             //               ),
//             //               hintText: "Restaurant name",
//             //             ),
//             //             style: const TextStyle(fontSize: 14),
//             //             onSubmitted: (value) {
//             //               // searchProvider.addSearchKey(value);
//             //             },
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ],
//             // ),
//             // const SizedBox(
//             //   height: 20.0,
//             // ),
//             // Consumer<SearchPageProvider>(
//             //   builder: (context, result, _) {
//             //     if (result.state == ResultState.NoKey) {
//             //       return SearchEmpty(
//             //         icon: Icons.search,
//             //         title: "Let's search your favorite restaurant",
//             //       );
//             //     } else if (result.state == ResultState.Loading) {
//             //       return SearchLoading(
//             //         title: "Please Wait",
//             //       );
//             //     } else if (result.state == ResultState.HasData) {
//             //       return Expanded(
//             //         child: ListView.separated(
//             //           shrinkWrap: true,
//             //           itemCount: result.searchRestaurant.restaurants.length,
//             //           itemBuilder: (context, index) {
//             //             var restaurant =
//             //                 result.searchRestaurant.restaurants[index];
//             //             return CardListRestaurant(
//             //               restaurant: restaurant,
//             //             );
//             //           },
//             //           separatorBuilder: (context, index) => const SizedBox(
//             //             height: 12,
//             //           ),
//             //         ),
//             //       );
//             //     } else if (result.state == ResultState.NoData) {
//             //       return SearchEmpty(
//             //         icon: Icons.search_off,
//             //         title: 'No restaurant list',
//             //       );
//             //     } else if (result.state == ResultState.Error) {
//             //       return SearchEmpty(
//             //         icon: Icons.cloud_off_sharp,
//             //         title: 'Failed to load restaurant data',
//             //       );
//             //     } else {
//             //       return Center(child: const Text(''));
//             //     }
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//   // return Container(
//   //     child: Row(
//   //   children: <Widget>[
//   //     TextField(
//   //       // onChanged: (value) {
//   //       //   setState(() {
//   //       //     _queries = value;
//   //       //   });
//   //       // },
//   //       decoration: InputDecoration(
//   //           prefixIcon: Icon(Icons.search),
//   //           border: InputBorder.none,
//   //           hintText: 'Search'),
//   //     ),
//   //   ],
//   // ));
// }
