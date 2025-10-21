import 'package:flutter/material.dart';
import 'package:flutter_cac/data/constants.dart';
import 'package:flutter_cac/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20.0),
      child: Column(
        children: [
          HeroWidget(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,),
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Welcome to this card',
                      style: textStyles.titleTealText,
                    ),
                    Text(
                      'Just a card',
                      style: textStyles.descriptionText,
                    ),
                  ],
                )
              ),
            ),
          )
        ],
      ), 
    );
  }
}