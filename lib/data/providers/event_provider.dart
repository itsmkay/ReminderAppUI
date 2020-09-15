import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../event_model.dart';

class EventProvider with ChangeNotifier {
  Map<DateTime, List<Event>> _userEvents = {
    DateTime.parse('2020-08-15'): [
      Event(
        'Date with Emma',
        'https://www.clipartkey.com/mpngs/m/77-776665_lunch-clipart-lunch-date-couple-date-night-cartoon.png',
        '00:00',
        'Dominos',
      ),
      Event(
        'Natasha\'s birthday',
        'https://www.pngitem.com/pimgs/m/66-669045_gateaux-cartoon-birthday-cake-birthday-cake-clip-art.png',
        '00:00',
        'Natasha\'s home',
      ),
      Event(
        'Project deadline',
        'https://image.freepik.com/free-vector/deadline-workload-pressure-cartoon_1284-23139.jpg',
        '00:00',
        'My office',
      )
    ],
    DateTime.parse('2020-08-15').subtract(
      Duration(days: 2),
    ): [
      Event(
        'Business meeting',
        'https://image.freepik.com/free-vector/business-meeting-cartoon_18591-40653.jpg',
        '00:00',
        'ASV, Chennai',
      )
    ],
    DateTime.parse('2020-08-15').add(
      Duration(days: 5),
    ): [
      Event(
        'Jack\'s birthday',
        'https://www.pngitem.com/pimgs/m/66-669045_gateaux-cartoon-birthday-cake-birthday-cake-clip-art.png',
        '00:00',
        'Jack\'s home',
      )
    ],
    DateTime.parse('2020-08-15').add(
      Duration(days: 8),
    ): [
      Event(
        'Doctor\'s appoinment',
        'https://thumbs.dreamstime.com/b/medical-consultation-cartoon-doctor-measuring-blood-pressure-male-patient-medical-consultation-cartoon-doctor-measuring-blood-157278583.jpg',
        '00:00',
        'Fortis hospital',
      )
    ]
  };

  Map<DateTime, List<Event>> get userEvents {
    return {..._userEvents};
  }

  void addEvent(DateTime date, String title, String note, String time) {
    Event newEvent = Event(
          title,
          'https://thumbs.dreamstime.com/b/medical-consultation-cartoon-doctor-measuring-blood-pressure-male-patient-medical-consultation-cartoon-doctor-measuring-blood-157278583.jpg',
          time,
          note,
        );
    Map<DateTime, List<Event>> newEntries = {
      date: [
        newEvent
      ],
    };
    if(_userEvents[date]!=null){
      _userEvents[date].insert(0, newEvent);
    }
    else{
      _userEvents = _userEvents..addAll(newEntries);
    }
    notifyListeners();
  }

  Function get addEventFunction {
    return addEvent;
  }
}
