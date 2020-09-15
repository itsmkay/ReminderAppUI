import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/data/providers/event_provider.dart';
import 'package:reminder/screens/add_plan_screen.dart';
import 'package:reminder/widgets/event_item.dart';
import 'package:reminder/widgets/my_app_bar.dart';
import 'package:reminder/widgets/no_event_item.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<DateTime, List<dynamic>> userEvents;
  bool init = true;
  DateTime selectedDay = DateTime.now();
  List<dynamic> selectedEvents;
  void setSelectedDate(DateTime day, List<dynamic> events) {
    setState(() {
      selectedDay = day;
      selectedEvents = events;
    });
  }

  @override
  void didChangeDependencies() {
    if (init) {
      userEvents = Provider.of<EventProvider>(context).userEvents;
      selectedEvents = userEvents[selectedDay] ?? [];
      init = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: CustomScrollView(
        slivers: [
          MyAppBar(setSelectedDate),
          SliverList(
            delegate: selectedEvents.length == 0
                ? SliverChildListDelegate([
                    NoEventItem(),
                  ])
                : SliverChildBuilderDelegate(
                    (ctx, index) {
                      return EventItem(
                        title: selectedEvents[index].title,
                        location: selectedEvents[index].location,
                        time: selectedEvents[index].time,
                        imageUrl: selectedEvents[index].imageUrl,
                      );
                    },
                    childCount: selectedEvents.length,
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              colors: [Colors.purple, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => AddPlanScreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
