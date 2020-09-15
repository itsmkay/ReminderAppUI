import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:reminder/data/providers/event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AddPlanScreen extends StatefulWidget {
  @override
  _AddPlanScreenState createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  bool allDaySelected = false;
  bool timeSelected = true;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  CalendarController _calendarController = CalendarController();
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  FocusNode _notesFocusNode = FocusNode();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void setAllDay() {
    setState(() {
      allDaySelected = true;
      timeSelected = false;
    });
  }

  Future<void> setTime(BuildContext context) async {
    TimeOfDay time;
    await showTimePicker(context: context, initialTime: selectedTime)
        .then((value) {
      time = value != null ? value : selectedTime;
    });
    setState(() {
      allDaySelected = false;
      timeSelected = true;
      selectedTime = time;
    });
  }

  ScrollController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = ScrollController();
    ctrl.addListener(() => setState(() {}));
  }

  _buildEdge() {
    var edgeHeight = 20.0;
    var paddingTop = MediaQuery.of(context).padding.top+1;

    var defaultOffset = (paddingTop + 180) - edgeHeight;

    var top = defaultOffset;
    var edgeSize = edgeHeight;

    if (ctrl.hasClients) {
      double offset = ctrl.offset;
      top -= offset > 0 ? offset : 0;

      if (false) {
        // Hide edge to prevent overlapping the toolbar during scroll.
        var breakpoint = 180 - kToolbarHeight - edgeHeight;

        if (offset >= breakpoint) {
          edgeSize = edgeHeight - (offset - breakpoint);
          if (edgeSize < 0) {
            edgeSize = 0;
          }

          top += (edgeHeight - edgeSize);
        }
      }
    }

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Container(
        height: edgeSize,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Function addEvent = Provider.of<EventProvider>(context).addEvent;
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(
          controller: ctrl,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipPath(
                  //clipper: MyClipper(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Add a plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple[300], Colors.purple[900]],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 3.0), //(x,y)
                                    blurRadius: 15.0,
                                    spreadRadius: 3)
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple[300],
                                  Colors.purple[900]
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: TableCalendar(
                            onDaySelected: (date, events) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            initialCalendarFormat: CalendarFormat.twoWeeks,
                            availableCalendarFormats: {
                              CalendarFormat.twoWeeks: 'Two Weeks',
                              CalendarFormat.month: 'Month'
                            },
                            calendarController: _calendarController,
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              centerHeaderTitle: true,
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.arrow_left,
                                color: Colors.transparent,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_right,
                                color: Colors.transparent,
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              weekendStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            calendarStyle: CalendarStyle(
                                weekdayStyle: TextStyle(color: Colors.white),
                                weekendStyle: TextStyle(color: Colors.white),
                                outsideDaysVisible: false,
                                todayColor: Colors.transparent),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.0), //(x,y)
                              blurRadius: 8.0,
                            )
                          ]),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: setAllDay,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'All day',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: allDaySelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: allDaySelected
                                            ? Colors.transparent
                                            : Colors.purple[300]),
                                    gradient: LinearGradient(
                                      colors: allDaySelected
                                          ? [
                                              Colors.purple[300],
                                              Colors.purple[900]
                                            ]
                                          : [Colors.white, Colors.white],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setTime(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      selectedTime.format(context),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: timeSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: timeSelected
                                            ? Colors.transparent
                                            : Colors.purple[300]),
                                    gradient: LinearGradient(
                                      colors: timeSelected
                                          ? [
                                              Colors.purple[300],
                                              Colors.purple[900]
                                            ]
                                          : [Colors.white, Colors.white],
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                            validator: (textEntered) {
                              if (textEntered == '') {
                                return 'Please enter title';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            controller: _titleTextController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_notesFocusNode);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Title',
                                labelStyle: TextStyle(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            focusNode: _notesFocusNode,
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            controller: _notesController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Note',
                                labelStyle: TextStyle(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FlatButton(
                                  onPressed: () {
                                     if(_titleTextController.text.isEmpty){
                                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please provide a title'),));
                                        
                                        return;
                                      }
                                    addEvent(
                                     
                                      DateTime.parse(DateFormat('yyyy-MM-dd')
                                          .format(selectedDate)),
                                      _titleTextController.text,
                                      _notesController.text,
                                      allDaySelected
                                          ? 'All day'
                                          : selectedTime.format(context),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 10,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple[300],
                                    Colors.purple[900]
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        _buildEdge()
      ]),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(0, size.height - 30, 30, size.height - 30)
      ..lineTo(size.width - 30, size.height - 30)
      ..quadraticBezierTo(size.width, size.height - 30, size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
