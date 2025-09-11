import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';
import 'package:tasky_app/features/home/data/firebase/task_firebase.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/view/presentation/home_screen.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key, this.task});

  final TaskModel? task;
  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Color(0xffE0DFE3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset("assets/icons/remove-icon.png"),
                ),
              ),
              SizedBox(height: 50),
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await TaskFirebase.updateDoneTask(widget.task!.id);
                      setState(() {
                        widget.task!.isDone = !(widget.task!.isDone ?? false);
                      });
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff5F33E1), width: 3),
                      ),
                      child: widget.task!.isDone
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
                  Text(
                    widget.task!.title ?? " ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 33),
                child: Text(
                  widget.task!.desc ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6E6A7C),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                spacing: 10,
                children: [
                  Image.asset("assets/icons/timer-icon.png"),
                  Text(
                    "Task Time:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffE0DFE3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(widget.task!.date!.day == DateTime.now().day
                    ? "Today"
                    : widget.task!.date!.day == DateTime.now().add(Duration(days: 1)).day
                    ? "Tomorrow"
                    : widget.task!.date!.day < DateTime.now().add(Duration(days: 7)).day
                    ? DateFormat('EEE').format(widget.task!.date!)
                    : "${widget.task!.date!.day}/${widget.task!.date!.month}/${widget.task!.date!.year}"),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                spacing: 13,
                children: [
                  Image.asset("assets/icons/priority-icon.png"),
                  Text(
                    "Task Priority:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffE0DFE3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(widget.task!.priority!.toString()),
                  ),
                ],
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  await TaskFirebase.deleteTask(widget.task!.id!);
                  Navigator.of(context).pop();
                },
                child: Row(
                  spacing: 13,
                  children: [
                    Image.asset("assets/icons/trash-icon.png"),
                    Text(
                      "Delete Task",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              MaterialButtonWidget(
                title: "Edit Task",
                onPressed: () {},
                loading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
