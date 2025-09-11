import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';
import 'package:tasky_app/features/home/view/widgets/priority_item_widget.dart';

class ShowPriorityDialogWidget extends StatefulWidget {
  const ShowPriorityDialogWidget({
    super.key,
    required this.onTap,
    this.initpriority,
  });
  final Function(int) onTap;
  final int? initpriority;
  @override
  State<ShowPriorityDialogWidget> createState() =>
      _ShowPriorityDialogWidgetState();
}

class _ShowPriorityDialogWidgetState extends State<ShowPriorityDialogWidget> {
  List<int> priority = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int? selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.initpriority ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            "Task Priority",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Divider(color: Color(0xff979797)),
        ],
      ),
      content: Wrap(
        runSpacing: 15,
        spacing: 10,
        children: priority
            .map<PriorityItemWidget>(
              (int index) => PriorityItemWidget(
                index: index,
                isSelected: index == selectedPriority ? true : false,
                onTap: () {
                  selectedPriority = index;
                  setState(() {});
                  widget.onTap(index);
                },
              ),
            )
            .toList(),
      ),
      actions: [
        Expanded(
          child: MaterialButtonWidget(
            loading: false,
            title: "Save",
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
