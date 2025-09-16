import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';
import 'package:tasky_app/features/auth/veiw/widgets/text_form_feild_helper.dart';
import 'package:tasky_app/features/home/data/firebase/task_firebase.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/view/presentation/home_screen.dart';
import 'package:tasky_app/features/home/view/widgets/calendar_widget.dart';
import 'package:tasky_app/features/home/view/widgets/show_priority_dialog_widget.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key, this.task});

  final TaskModel? task;
  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  var title = TextEditingController();
  var desc = TextEditingController();
  var selectedDate;
  var selectedPriority;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.task!.title);
    desc = TextEditingController(text: widget.task!.desc);
    selectedDate = widget.task!.date;
    selectedPriority = widget.task!.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
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
                          border: Border.all(
                            color: Color(0xff5F33E1),
                            width: 3,
                          ),
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
                    Expanded(
                      child: TextFormFieldHelper(
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff24252C),
                        ),
                        controller: title,
                        minLines: 1,
                        maxLines: 2,
                        hasBorder: false,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: TextFormFieldHelper(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6E6A7C),
                    ),
                    controller: desc,
                    minLines: 1,
                    maxLines: 5,
                    hasBorder: false,
                    action: TextInputAction.done,
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
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => CalendarDialog(
                            selectedDate: (date) {
                              selectedDate = date;
                              setState(() {});
                            },
                            initDate: selectedDate,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE0DFE3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          selectedDate.day == DateTime.now().day
                              ? "Today"
                              : selectedDate.day ==
                                    DateTime.now().add(Duration(days: 1)).day
                              ? "Tomorrow"
                              : selectedDate.day <
                                    DateTime.now().add(Duration(days: 7)).day
                              ? DateFormat('EEE').format(widget.task!.date!)
                              : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        ),
                      ),
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowPriorityDialogWidget(
                            onTap: (priority) {
                              selectedPriority = priority;
                              setState(() {});
                            },
                            initpriority: selectedPriority,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE0DFE3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(selectedPriority.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    await TaskFirebase.deleteTask(widget.task!.id);
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
                SizedBox(height: 300),
                Positioned(
                  child: MaterialButtonWidget(
                    title: "Edit Task",
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      );
                      await TaskFirebase.updateTask(
                        widget.task!.id,
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
                    loading: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


