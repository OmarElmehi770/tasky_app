import 'package:flutter/material.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        children: [
          Spacer(flex: 1),
          Image.asset("assets/images/empty.png"),
          Text(
            "What do you want to do today?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xff404147),
            ),
          ),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff404147),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
