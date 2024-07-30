import 'package:flutter/material.dart';

import '../../../../core/utils/helpers/text_form_date.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // WidgetList(),
          DefaultDateTimeTextField(
            controller: controller,
            onDateTimeChange: (dateTime) {
              // controller.text = dateTime;
            },

            // initDate: DateTime.now(),
            label: "Select Date and Time",
            helperText: "Tap to select date and time",
            // icon: Icons.calendar_today,
            suffixIcon: Icons.access_time,
            borderLess: false,
          ),
        ],
      ),
    );
  }
}
