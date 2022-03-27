import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/provider/search_provider.dart';
import 'package:yess_nutrion/resto_page.dart';
import 'package:yess_nutrion/widget/resto_list.dart';

class SearchResto extends StatefulWidget {
  static const routeName = '/resto_search';
  @override
  State<SearchResto> createState() => _SearchRestoState();
}

class _SearchRestoState extends State<SearchResto> {
  String _queries = '';

  Widget _buildResto(BuildContext context) {
    return Consumer<SearchRestoProvider>(builder: (context, state, _) {
      if (state.state == SearchState.Loading) {
        return Center(
            child: Container(
          child: Text('Cari Restoran mu'),
        ));
      } else if (state.state == SearchState.HasData) {
        // state.fetchSearchRestaurant(queries);
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              var resto = state.result!.restaurants[index];
              return ListResto(resto: resto);
            });
      } else if (state.state == SearchState.NoData) {
        return Text(state.message);
      } else if (state.state == SearchState.Error) {
        return (Text(state.message));
      } else {
        return Center(
          child: Text(''),
        );
      }
    }

        // ignore: dead_code
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestoProvider>(
      builder: (context, state, _) {
        return Container(
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
                  onChanged: (value) {
                    setState(() {
                      _queries = value;
                    });
                    state.fetcSearchResto(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Search'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
