import 'package:flutter/material.dart';

class NoEventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Man_Relaxing_on_the_Beach_Cartoon_Vector.svg/1280px-Man_Relaxing_on_the_Beach_Cartoon_Vector.svg.png',
            width: 250,
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sit back and relax, you have no reminders for this day',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
