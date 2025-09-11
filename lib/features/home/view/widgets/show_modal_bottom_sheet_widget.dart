
import 'package:flutter/material.dart';
import 'package:tasky_app/features/auth/veiw/widgets/text_form_feild_helper.dart';

class ShowModalBottomSheetWidget extends StatelessWidget {
  const ShowModalBottomSheetWidget({
    super.key,
    required this.title,
    required this.desc,
    this.onTapDate,
    this.onTapPriority,
    this.onTapSend,
  });

  final TextEditingController title;
  final TextEditingController desc;
  final void Function()? onTapDate;
  final void Function()? onTapPriority;
  final void Function()? onTapSend;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Task",
            style: TextStyle(
              color: Color(0xff404147),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormFieldHelper(
            controller: title,
            borderRadius: BorderRadius.circular(8),
            hint: "title",
          ),
          TextFormFieldHelper(
            controller: desc,
            borderRadius: BorderRadius.circular(8),
            hint: "description",
            action: TextInputAction.done,
          ),
          Row(
            spacing: 10,
            children: [
              GestureDetector(
                onTap: onTapDate,
                child: Image.asset("assets/icons/timer-icon.png"),
              ),
              GestureDetector(
                onTap: onTapPriority,
                child: Image.asset("assets/icons/priority-icon.png"),
              ),
              Spacer(),
              GestureDetector(
                onTap: onTapSend,
                child: Image.asset("assets/icons/send-icon.png"),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}