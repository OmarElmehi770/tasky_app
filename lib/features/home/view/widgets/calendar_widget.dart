import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key, required this.selectedDate, this.initDate})
    : super(key: key);

  final Function(DateTime) selectedDate;
  final DateTime? initDate;
  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initDate ?? DateTime.now();
    _focusedDay = _selectedDay!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        width: 350,
        height: 360,
        child: Column(
          children: [
            Text(
              "${DateFormat.MMMM().format(_focusedDay).toUpperCase()}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "${DateTime.now().year}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Divider(),
            TableCalendar(
              rowHeight: 40,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final text = DateFormat.E().format(day).toUpperCase();
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: text == "SUN" || text == "SAT"
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              focusedDay: _focusedDay,
              onPageChanged: (newdate) {
                _focusedDay = newdate;
                setState(() {});
              },
              headerVisible: false,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 51)),
              currentDay: _selectedDay ?? DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                ),
                defaultDecoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                ),
                weekendDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                disabledDecoration: BoxDecoration(shape: BoxShape.rectangle),
                defaultTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: const TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButtonWidget(
                    loading: false,
                    title: "Save",
                    onPressed: () {
                      widget.selectedDate(_selectedDay!);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
