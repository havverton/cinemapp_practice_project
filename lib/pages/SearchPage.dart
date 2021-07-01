import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:cinemapp_practice_project/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackGrndColor,
      body: Column(
        children: [
          HeaderWidget(),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEBEBEB), borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    print("${_searchController.text}");
                    //TODO Реализовать поиск
                  },
                  controller: _searchController,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFEBEBEB),
                    hintText: "Search",

                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFB5B5B5),
                    ),

                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    prefixStyle: TextStyle(
                      color: Color(0xFFEBEBEB),
                    ),
                    focusColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
