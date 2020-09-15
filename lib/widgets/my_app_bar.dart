import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/widgets/user_calendar.dart';

class MyAppBar extends StatelessWidget {
  final Function setSelectedDate;
  MyAppBar(this.setSelectedDate);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text('Schedule in ' + DateFormat.yMMMM().format(DateTime.now())),
      expandedHeight: 380,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[900], Colors.purple[400]],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
            ),
            boxShadow: [new BoxShadow(blurRadius: 30.0)],
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width - 20, 70),
            ),
          ),
          child: UserCalendar(setSelectedDate),
        ),
      ),
    );
  }
}
