import 'package:flutter/material.dart';
import 'package:flutter_cac/views/pages/get_started_page.dart';
import 'package:flutter_cac/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsetsGeometry.all(20.0),
            child: FittedBox(
              child: Column(
                children: [
                  Text(
                    'CAC App',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 25.0,
                    ),
                  ),
                  Center(
                    child: Lottie.asset(
                      'assets/lotties/home1.json',
                      fit: BoxFit.fill
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.push( //! Consider changing to a pushReplacement
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return GetStartedPage();
                          }
                        )
                      );
                    },
                    child: Text('Get Started'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return WidgetTree();
                          }
                        )
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}