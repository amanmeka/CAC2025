import 'package:flutter/material.dart';
import 'package:flutter_cac/data/constants.dart';
import 'package:flutter_cac/data/notifiers.dart';
import 'package:flutter_cac/views/pages/new_task_page.dart';
import 'package:flutter_cac/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(20.0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsGeometry.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          selectedPageNotifier.value = 1;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 5,),
                            Text('Add a new task'),
                          ],
                        )
                      )
                    ],
                  )
                )
              ),
            )
          ],
        ), 
      ),
    );
  }
}