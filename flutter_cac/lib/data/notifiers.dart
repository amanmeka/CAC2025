//ValueNotifier
//ValueListenableBuilder: listen to the data (don't need the setState)

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true); 
ValueNotifier<bool> showAddTaskDialogNotifier = ValueNotifier(false);