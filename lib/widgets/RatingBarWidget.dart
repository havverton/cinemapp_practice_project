import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatefulWidget {
  final double rating;
  RatingBarWidget(this.rating) : super();

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState(this.rating);
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  double rating;
  _RatingBarWidgetState(this.rating);


  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: this.rating/2 ,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: kSecondaryColor,
      ),
      itemCount: 5,
      itemSize: 15.0,
      direction: Axis.horizontal,
    );
  }
}
