
import 'package:flutter/material.dart';

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget({
    super.key,
    required this.index,
    required this.isSelected,
    this.onTap,
  });

  final int index;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff5F33E1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: Color(0xff6E6A7C)),
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/icons/priority-icon.png",
              color: isSelected ? Colors.white : Color(0xff5F33E1),
            ),
            Text(
              "$index",
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
