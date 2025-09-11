import 'package:flutter/material.dart';

class HaveAccountQuestionWidget extends StatelessWidget {
  const HaveAccountQuestionWidget({
    super.key,
    required this.onPressed,
    required this.questionString,
    required this.actionString,
  });
  final void Function()? onPressed;
  final String questionString ;
  final String actionString ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(questionString,style: TextStyle(fontSize: 10),),
        TextButton(
          onPressed: onPressed,
          child: Text(actionString,style: TextStyle(color: Color(0xff5F33E1),fontSize: 10,fontWeight: FontWeight.bold),),),
      ],
    );
  }
}