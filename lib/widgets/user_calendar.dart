import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/data/event_model.dart';
import 'package:reminder/data/providers/event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UserCalendar extends StatefulWidget {
  final Function setSelectedDate;
  UserCalendar(this.setSelectedDate);
  @override
  _UserCalendarState createState() => _UserCalendarState();
}

class _UserCalendarState extends State<UserCalendar> {
  final CalendarController _calendarController = CalendarController();
  DateTime selectedDay = DateTime.now();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map<DateTime, List<Event>> userEvents =
        Provider.of<EventProvider>(context).userEvents;
    
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: TableCalendar(
        initialSelectedDay: selectedDay,
        events: userEvents,
        calendarController: _calendarController,
        headerVisible: false,
        rowHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          weekendStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        calendarStyle: CalendarStyle(
          markersColor: Colors.yellow,
          weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Colors.white),
          outsideDaysVisible: false,
        ),
        availableGestures: AvailableGestures.horizontalSwipe,
        onDaySelected: (day, events) {
          setState(() {
            selectedDay = day;
          });
          widget.setSelectedDate(day,events);
        },
      ),
    );
  }
}
