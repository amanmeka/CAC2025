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
                        onPressed: () async {
                          // Switch to Task page
                          selectedPageNotifier.value = 1;

                          // Wait one frame so TaskPage can mount
                          await Future.delayed(const Duration(milliseconds: 100));

                          // Trigger the dialog once TaskPage is ready
                          showAddTaskDialogNotifier.value = true;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add),
                            SizedBox(width: 5),
                            Text('Add a new task'),
                          ],
                        ),
                      ),
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