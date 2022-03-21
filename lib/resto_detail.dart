import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/recomend_resto.dart';
import 'package:yess_nutrion/styles.dart';
import 'package:yess_nutrion/widget/DrinkList.dart';
import 'package:yess_nutrion/widget/FoodList.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';
  final Resto resto;

  const DetailResto({required this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                            image: NetworkImage(resto.pictureId),
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
                          resto.name,
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
                            Text(resto.city)
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
                        Text(resto.description),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Foods',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        FoodList(resto: resto),
                        SizedBox(height: 30),
                        Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        DrinkList(resto: resto),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
