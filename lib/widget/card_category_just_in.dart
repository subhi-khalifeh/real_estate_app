import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class CardJustIn extends StatelessWidget {
  String imageUrl;

  CardJustIn(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: ImageCard(
              imageUrl: imageUrl,
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.width * .5,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.06,
              left: MediaQuery.of(context).size.width * 0.06,
              bottom: MediaQuery.of(context).size.width * 0.01),
          child: Row(
            children: <Widget>[
              PropertyCardPrice(
                price: "\$4999 ",
                colorPrice: Colors.black,
              ),
              PropertyCardPrice(
                price: " - 5999",
                colorPrice: Colors.black,
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.01,
              left: MediaQuery.of(context).size.width * 0.06,
              bottom: MediaQuery.of(context).size.width * 0.03),
          child: Container(
          width:  MediaQuery.of(context).size.width * .5,
            child: Row(
              children: <Widget>[
                PropertyCardDescription(
                  description: "1-4 Beds,",
                  colorDescription: Colors.black87,
                ),
                PropertyCardDescription(
                  description: "1-2 Beds ",
                  colorDescription: Colors.black87,
                ),
              ],
            ),
          ),
        ),
//
        Container(
          width: MediaQuery.of(context).size.width * .5,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
                bottom: MediaQuery.of(context).size.width * 0.06),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on ,color: activeIconNavBar,size: 14,),
                SizedBox(width: 5,),
                PropertyCardDescription(
                  description: '252 1st Avenue',
                  colorDescription: Colors.black38,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
