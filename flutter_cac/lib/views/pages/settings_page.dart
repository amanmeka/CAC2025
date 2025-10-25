import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cac/data/constants.dart';
import 'package:flutter_cac/data/database_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.title
  });
  
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Snack Bar'),
                      behavior: SnackBarBehavior.floating,
                    )
                  );
                },
                child: Text("Snack Bar!"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              Divider(
                color: Colors.teal,
                thickness: 2.0,
                endIndent: 200.0,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: Text('ALERT!'),
                        title: Text('Alert'),
                        actions: [
                          CloseButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Text("Open Dialog!"),
              ),
              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(child: Text('Element 1'), value: 'e1',),
                  DropdownMenuItem(child: Text('Element 2'), value: 'e2',)
                ],
                onChanged: (value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () => setState(() {}),
                ),
                Text(controller.text),
                Checkbox(
                  tristate: false,
                  value: isChecked, 
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                CheckboxListTile.adaptive(
                  tristate: false,
                  title: Text("Check Me!"),
                  value: isChecked, 
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  }
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
                SwitchListTile.adaptive(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  title: Text("Flutter Switch"),
                ),
                Slider.adaptive(
                  value: sliderValue,
                  divisions: 20,
                  onChanged: (double value) {
                    setState(() {
                      sliderValue = value;
                      print(sliderValue);
                    });
                  },
                ),
                InkWell(
                  splashColor: Colors.teal,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white12,
                  ),
                  onTap: () {
                    print("image selected");
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("change from red to blue."),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text("Click Me"),
                ),
                CloseButton(
                  onPressed: () {},
                ),
                BackButton(
                  onPressed: () {},
                ),
                OutlinedButton(
                  onPressed: () {
                    DatabaseService().create(path: 'data1', data: {'name': 'Flutter Pro'});
                  },
                  child: Text("Data1 in database"),
                ),
                TextButton(
                  onPressed: () async {
                    DataSnapshot? snap = await DatabaseService().read(path: 'data1');
                    if (snap != null) {
                      print(snap.value);
                    }
                  },
                  child: Text("What is in data1?"),
                ),
            ],
          ),
        ),
      )
    );
  }
}