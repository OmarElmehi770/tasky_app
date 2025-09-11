import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItemWidget extends StatefulWidget {
  TaskItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.isDone,
    required this.onTap,
  });
  final String? title;
  final String? description;
  final DateTime? date;
  final int? priority;
  bool isDone = false;
  void Function()? onTap;
  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xff6E6A7C)),
      ),
      child: Row(
        spacing: 10,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff5F33E1), width: 3),
              ),
              child: widget.isDone
                  ? Center(
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Color(0xff5F33E1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          // Radio(
          //   value: isDone,
          //   groupValue: isDone,
          //   onChanged: (val) {
          //     isDone != val;
          //     setState(() {});
          //     log("haloo");
          //   },
          //   activeColor: Color(0xff5F33E1),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                widget.title ?? "",
                style: TextStyle(
                  color: Color(0xff404147),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${widget.date!.day == DateTime.now().day
                    ? "Today"
                    : widget.date!.day == DateTime.now().add(Duration(days: 1)).day
                    ? "Tomorrow"
                    : widget.date!.day < DateTime.now().add(Duration(days: 7)).day
                    ? DateFormat('EEE').format(widget.date!)
                    : "${widget.date!.day}/${widget.date!.month}/${widget.date!.year}"} AT ${widget.date!.hour}:${widget.date!.minute}",
                style: TextStyle(
                  color: Color(0xff6E6A7C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xff6E6A7C)),
            ),
            child: Row(
              spacing: 5,
              children: [
                Image.asset(
                  "assets/icons/priority-icon.png",
                  color: Color(0xff5F33E1),
                ),
                Text(
                  widget.priority.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
