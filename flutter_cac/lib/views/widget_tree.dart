import 'package:flutter/material.dart';
import 'package:flutter_cac/data/notifiers.dart';
import 'package:flutter_cac/views/pages/home_page.dart';
import 'package:flutter_cac/views/pages/new_task_page.dart';
import 'package:flutter_cac/views/pages/profile_page.dart';
import 'package:flutter_cac/views/pages/settings_page.dart';
import 'package:flutter_cac/views/widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  TaskPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter"),
          actions: [
            IconButton(
              onPressed: () {
                isDarkModeNotifier.value = !isDarkModeNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isDarkModeNotifier, 
                builder: (context, isDarkMode, child) {
                  return Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode
                  );
                }
              )
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(
                        title: 'Settings'
                      );
                    }
                  )
                );
              },
            )
          ],
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
            valueListenable: selectedPageNotifier, 
            builder: (context, selectedPage, child) {
              return pages.elementAt(selectedPage);
            }
          ),
        bottomNavigationBar: NavbarWidget()
      );
  }
}