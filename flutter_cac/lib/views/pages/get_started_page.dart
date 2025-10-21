import 'package:flutter/material.dart';
import 'package:flutter_cac/data/constants.dart';
import 'package:lottie/lottie.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Get Started',
          style: textStyles.titleTealText
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/login2.json'),
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'To get started login with either email or google',
                  style: textStyles.descriptionText,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}