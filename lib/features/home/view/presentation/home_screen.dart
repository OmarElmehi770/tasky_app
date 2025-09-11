import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/features/auth/veiw/presentation/login-scrren.dart';
import 'package:tasky_app/features/home/data/firebase/task_firebase.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/view/presentation/detailed_screen.dart';
import 'package:tasky_app/features/home/view/widgets/calendar_widget.dart';
import 'package:tasky_app/features/home/view/widgets/empty_tasks.dart';
import 'package:tasky_app/features/home/view/widgets/show_modal_bottom_sheet_widget.dart';
import 'package:tasky_app/features/home/view/widgets/show_priority_dialog_widget.dart';
import 'package:tasky_app/features/home/view/widgets/task_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var title = TextEditingController();
  var desc = TextEditingController();
  var selectedDate = DateTime.now();
  var selectedPriority = 1;
  String selectedDay = "All";
  List<String> days = ["All", "Today", "Tomorrow", "This Week"];

  List<TaskModel> filterTasks(List<TaskModel> tasks) {
    DateTime now = DateTime.now();

    if (selectedDay == "Today") {
      return tasks
          .where(
            (task) =>
                task.date!.year == now.year &&
                task.date!.month == now.month &&
                task.date!.day == now.day,
          )
          .toList();
    } else if (selectedDay == "Tomorrow") {
      DateTime tomorrow = now.add(Duration(days: 1));
      return tasks
          .where(
            (task) =>
                task.date!.year == tomorrow.year &&
                task.date!.month == tomorrow.month &&
                task.date!.day == tomorrow.day,
          )
          .toList();
    } else if (selectedDay == "This Week") {
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      return tasks
          .where(
            (task) =>
                task.date!.isAfter(
                  startOfWeek.subtract(Duration(seconds: 1)),
                ) &&
                task.date!.isBefore(endOfWeek.add(Duration(seconds: 1))),
          )
          .toList();
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Task",
              style: GoogleFonts.baloo2(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "y",
              style: GoogleFonts.baloo2(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xffF5F876),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: Row(
              children: [
                Image.asset("assets/icons/logout-icon.png"),
                SizedBox(width: 5),
                Text(
                  "Log out",
                  style: TextStyle(
                    color: Color(0xffFF4949),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: TaskFirebase.isEmpty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.data == true) {
            return EmptyTasks();
          } else {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xff6E6A7C)),
                    ),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      icon: Image.asset("assets/icons/arrow-down.png"),
                      value: selectedDay,
                      items: days.map((day) {
                        return DropdownMenuItem(value: day, child: Text(day));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDay = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder(
                      future: TaskFirebase.getNotCompletedTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<TaskModel> filteredTasks = filterTasks(
                          snapshot.data!,
                        );

                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailedScreen(
                                      task: filteredTasks[index],
                                    ),
                                  ),
                                )
                                .then((_) {
                                  setState(() {});
                                }),
                            child: TaskItemWidget(
                              title: filteredTasks[index].title,
                              description: filteredTasks[index].desc,
                              priority: filteredTasks[index].priority,
                              date: filteredTasks[index].date,
                              isDone: filteredTasks[index].isDone,
                              onTap: () {
                                TaskFirebase.updateDoneTask(
                                  snapshot.data![index].id,
                                );
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xff6E6A7C)),
                    ),
                    child: Text("Completed", style: TextStyle(fontSize: 20)),
                  ),
                  Expanded(
                    flex: 1,
                    child: FutureBuilder(
                      future: TaskFirebase.getCompletedTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<TaskModel> filteredTasks = filterTasks(
                          snapshot.data!,
                        );

                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedScreen(task: filteredTasks[index]),
                              ),
                            ).then((_) {
                                  setState(() {});
                                }),
                            child: TaskItemWidget(
                              title: filteredTasks[index].title,
                              description: filteredTasks[index].desc,
                              priority: filteredTasks[index].priority,
                              date: filteredTasks[index].date,
                              isDone: filteredTasks[index].isDone,
                              onTap: () {
                                TaskFirebase.updateDoneTask(
                                  snapshot.data![index].id,
                                );
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ShowModalBottomSheetWidget(
              title: title,
              desc: desc,
              onTapDate: () async {
                showDialog(
                  context: context,
                  builder: (context) => CalendarDialog(
                    selectedDate: (date) {
                      selectedDate = date;
                    },
                    initDate: selectedDate,
                  ),
                );
              },
              onTapPriority: () {
                showDialog(
                  context: context,
                  builder: (context) => ShowPriorityDialogWidget(
                    onTap: (priority) {
                      selectedPriority = priority;
                    },
                    initpriority: selectedPriority,
                  ),
                );
              },
              onTapSend: () async {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
                await TaskFirebase.addTask(
                  TaskModel(
                    title: title.text,
                    desc: desc.text,
                    date: selectedDate,
                    priority: selectedPriority,
                  ),
                );
                setState(() {});
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          );
        },
        backgroundColor: Color(0xff24252C),
        child: Icon(Icons.add, color: Color(0xff5F33E1), size: 30),
      ),
    );
  }
}
