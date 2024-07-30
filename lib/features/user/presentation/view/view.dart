import 'package:flutter/material.dart';

import '../../../../core/utils/helpers/date/DateTimeUtils.dart';
import '../../../../core/utils/helpers/date/DefaultDateTimeTextFieldNew.dart';
import '../../../../core/utils/helpers/text_form_date.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final TextEditingController controller = TextEditingController();
  final TextEditingController dateAndTimecontroller = TextEditingController();
  final TextEditingController newC = TextEditingController();
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
            // helperText: "Tap to select date and time",
            // icon: Icons.calendar_today,
            suffixIcon: Icons.access_time,
            borderLess: false,
          ),
          const SizedBox(height: 30),
          // DefaultDateAndTimeTextField(
          //   controller: dateAndTimecontroller,
          //   onDateTimeChange: (dateTime) {},
          //   // initDate: DateTime.now(),
          //   label: "Select Date and Time",
          //   // helperText: "Tap to select date and time",
          //   // icon: Icons.calendar_today,
          //   suffixIcon: Icons.access_time,
          //   mode: DateTimeMode.both, // حدد الوضع هنا
          // ),
          const SizedBox(height: 30),
          DefaultDateTimeTextFieldNew(
            onDateTimeChange: (dateTime) {},
            initDate: DateTime.now(),
            controller: newC,
            label: "Select Date and Time",
            // helperText: "Tap to select date and time",
            // icon: Icons.calendar_today,
            suffixIcon: Icons.access_time,
            mode: DateTimeMode.date, // حدد الوضع هنا
            calendarType: CalendarType.hijri, // حدد نوع التقويم هنا
          ),
        ],
      ),
    );
  }
}
