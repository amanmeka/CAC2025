import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class _CalendarPageState extends State<CalendarPage> {

  final List<Appointment> _appointments = [];

  late AppointmentDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = AppointmentDataSource(_appointments);
  }

  void _showAddEventDialog(DateTime selectedDate) {
    String eventTitle = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Calendar Event'),
          content: TextField(
            onChanged: (value) {
              eventTitle = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter event title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (eventTitle.isNotEmpty) {
                  _addCalendarEvent(eventTitle, selectedDate); // Pass the date
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addCalendarEvent(String title, DateTime date) {
    final newEvent = Appointment(
      startTime: date,
      endTime: date.add(const Duration(hours: 1)), // 1 hour duration
      subject: title,
      color: Colors.blue,
      isAllDay: false,
    );

    setState(() {
      _appointments.add(newEvent);
      _dataSource.notifyListeners(CalendarDataSourceAction.add, [newEvent]);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: _dataSource,

          onTap: (calendarTapDetails) {
            if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
              final selectedDate = calendarTapDetails.date!;
              print('Tapped date: $selectedDate'); // DEBUG
              _showAddEventDialog(selectedDate);
            }
          },
        ),
      ),
    );
  }
}