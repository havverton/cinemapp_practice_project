import 'package:cinemapp_practice_project/MovieDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _MovieCardWidgetState extends State<MovieCardWidget>{
  final name;
  final reviews;
  _MovieCardWidgetState(this.name,this.reviews);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF191926),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailsWidget())),
        child: Column(
        children: [
          Stack(
              alignment: AlignmentDirectional(-1, 1),
              children: [
                DecoratedBox(
                  child: Image.asset(
                    "assets/images/tenet_poster.jpg",
                    fit: BoxFit.fill,
                  ),
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Color(0xFF191926),
                            Color(0x55191926)
                          ]
                      )
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Action",
                      style: TextStyle(fontSize: 10, color: Color(0xFFFF3466)),

                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color: Color(0xFFFF3466)),
                        Icon(Icons.star,color: Color(0xFFFF3466)),
                        Icon(Icons.star,color: Color(0xFFFF3466)),
                        Icon(Icons.star,color: Color(0xFFFF3466)),
                        Icon(Icons.star,color: Color(0xFFFF3466)),
                        Text("$reviews",
                            style: TextStyle(fontSize: 10, color: Color(0xFFFF3466))
                        )
                      ],
                    )
                  ],
                )
              ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "150 mins",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),),
    );
  }
  }


class MovieCardWidget extends StatefulWidget {
  final _name;
  final _reviews;
  MovieCardWidget(this._name, this._reviews);

  @override
  State<StatefulWidget> createState() {
    return _MovieCardWidgetState(_name, _reviews);
  }


  @override
  Widget build(BuildContext context) {


  }
}