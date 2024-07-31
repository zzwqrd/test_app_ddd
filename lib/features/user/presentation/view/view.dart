import 'package:flutter/material.dart';
import 'package:test_app_ddd/features/user/presentation/view/widgets/test_match.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final TextEditingController controller = TextEditingController();
  final TextEditingController dateAndTimecontroller = TextEditingController();
  final TextEditingController newC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
    // return Scaffold(
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       // WidgetList(),
    //       // DefaultDateTimeTextField(
    //       //   controller: controller,
    //       //   onDateTimeChange: (dateTime) {
    //       //     // controller.text = dateTime;
    //       //   },
    //       //
    //       //   // initDate: DateTime.now(),
    //       //   label: "Select Date and Time",
    //       //   // helperText: "Tap to select date and time",
    //       //   // icon: Icons.calendar_today,
    //       //   suffixIcon: Icons.access_time,
    //       //   borderLess: false,
    //       // ),
    //       const SizedBox(height: 30),
    //       // DefaultDateAndTimeTextField(
    //       //   controller: dateAndTimecontroller,
    //       //   onDateTimeChange: (dateTime) {},
    //       //   // initDate: DateTime.now(),
    //       //   label: "Select Date and Time",
    //       //   // helperText: "Tap to select date and time",
    //       //   // icon: Icons.calendar_today,
    //       //   suffixIcon: Icons.access_time,
    //       //   mode: DateTimeMode.both, // حدد الوضع هنا
    //       // ),
    //       // const SizedBox(height: 30),
    //       //// آخر تحديث للوقت والتاريخ والاثنين معا مع مراعات اظهار اسم الشهر او الرقم او اختيار الوقت او التاريخ او الاثنين معا او اختيار التاريخ ميلادي او هجري
    //       // DefaultDateTimeTextFieldNewOne(
    //       //   onDateTimeChange: (v) {},
    //       //   controller: newC,
    //       //   // initDate: DateTime.now(),
    //       //   label: "اختر التاريخ والوقت",
    //       //   // helperText: "اضغط لاختيار التاريخ والوقت",
    //       //   // icon: Icons.calendar_today,
    //       //   suffixIcon: Icons.access_time,
    //       //   mode: DateTimeMode.time,
    //       //   calendarType: CalendarType.gregorian, // اختر نوع التقويم
    //       //   dateDisplayFormat:
    //       //       DateDisplayFormat.numeric, // اختر طريقة عرض التاريخ
    //       // ),
    //       // DefaultDateTimeTextFieldNew(
    //       //   onDateTimeChange: (dateTime) {},
    //       //   initDate: DateTime.now(),
    //       //   controller: newC,
    //       //   label: "Select Date and Time",
    //       //   // helperText: "Tap to select date and time",
    //       //   // icon: Icons.calendar_today,
    //       //   suffixIcon: Icons.access_time,
    //       //   mode: DateTimeMode.date, // حدد الوضع هنا
    //       //   calendarType: CalendarType.hijri, // حدد نوع التقويم هنا
    //       // ),
    //     ],
    //   ),
    // );
  }
}
