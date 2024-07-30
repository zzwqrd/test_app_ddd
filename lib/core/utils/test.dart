// import 'package:bloc/bloc.dart';
// import 'DateTimeUtils.dart';
//
// class DateTimeCubit extends Cubit<CalendarType> {
//   DateTimeCubit() : super(CalendarType.gregorian);
//
//   void setCalendarType(CalendarType type) {
//     emit(type);
//   }
//
//   String formatDateTime(DateTime dateTime, DateTimeMode mode) {
//     return DateTimeUtils.formatDateTime(dateTime, mode, state);
//   }
//
//   DateTime parseDateTime(String dateTimeString, DateTimeMode mode) {
//     return DateTimeUtils.parseDateTime(dateTimeString, mode, state);
//   }
//
//   String convertToDisplayString(DateTime dateTime) {
//     return DateTimeUtils.convertToDisplayString(dateTime, state);
//   }
//
//   DateTime convertDateTime(DateTime dateTime) {
//     if (state == CalendarType.gregorian) {
//       // تحويل التاريخ الهجري إلى ميلادي
//       return DateTimeUtils.parseDateTime(DateTimeUtils.formatDateTime(dateTime, DateTimeMode.both, CalendarType.hijri), DateTimeMode.both, CalendarType.gregorian);
//     } else {
//       // تحويل التاريخ الميلادي إلى هجري
//       return DateTimeUtils.parseDateTime(DateTimeUtils.formatDateTime(dateTime, DateTimeMode.both, CalendarType.gregorian), DateTimeMode.both, CalendarType.hijri);
//     }
//   }
// }

// class Event {
//   String title;
//   DateTime date;
//
//   Event(this.title, this.date);
//
//   String getFormattedDate(DateTimeCubit dateTimeCubit) {
//     return dateTimeCubit.convertToDisplayString(date);
//   }
// }
//
// class Task {
//   String description;
//   DateTime dueDate;
//
//   Task(this.description, this.dueDate);
//
//   String getFormattedDate(DateTimeCubit dateTimeCubit) {
//     return dateTimeCubit.convertToDisplayString(dueDate);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'date_time_cubit.dart';
// import 'DateTimeUtils.dart';
//
// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Choose Calendar Type:', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<DateTimeCubit>().setCalendarType(CalendarType.gregorian);
//                   },
//                   child: Text('Gregorian'),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<DateTimeCubit>().setCalendarType(CalendarType.hijri);
//                   },
//                   child: Text('Hijri'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'date_time_cubit.dart';
// import 'DateTimeUtils.dart';
// import 'models/event.dart';
// import 'models/task.dart';
// import 'settings_screen.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'DateTime Conversion Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider(
//         create: (_) => DateTimeCubit(),
//         child: HomeScreen(),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Event> events = [
//     Event('Event 1', DateTime.now().subtract(Duration(days: 2))),
//     Event('Event 2', DateTime.now().add(Duration(days: 5))),
//   ];
//
//   List<Task> tasks = [
//     Task('Task 1', DateTime.now().add(Duration(days: 1))),
//     Task('Task 2', DateTime.now().add(Duration(days: 7))),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final dateTimeCubit = context.read<DateTimeCubit>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DateTime Conversion Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsScreen()),
//               ).then((_) {
//                 setState(() {});
//               });
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Events:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ...events.map((event) {
//               return ListTile(
//                 title: Text(event.title),
//                 subtitle: Text(event.getFormattedDate(dateTimeCubit)),
//               );
//             }).toList(),
//             SizedBox(height: 20),
//             Text('Tasks:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ...tasks.map((task) {
//               return ListTile(
//                 title: Text(task.description),
//                 subtitle: Text(task.getFormattedDate(dateTimeCubit)),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:intl/intl.dart';
//
// enum DateTimeMode { date, time, both }
// enum CalendarType { gregorian, hijri }
//
// class DateTimeUtils {
//   static String formatDateTime(DateTime dateTime, DateTimeMode mode, CalendarType calendarType) {
//     if (calendarType == CalendarType.gregorian) {
//       switch (mode) {
//         case DateTimeMode.date:
//           return DateFormat('dd MMMM yyyy', 'ar').format(dateTime);
//         case DateTimeMode.time:
//           return DateFormat('hh:mm a', 'ar').format(dateTime);
//         case DateTimeMode.both:
//           return '${DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}';
//       }
//     } else {
//       return formatHijriDate(dateTime, mode);
//     }
//   }
//
//   static String formatHijriDate(DateTime dateTime, DateTimeMode mode) {
//     final hijriYear = dateTime.year + 622 - (dateTime.month > 2 ? 1 : 0);
//     final hijriMonth = (dateTime.month + 9) % 12 + 1;
//     final hijriDay = dateTime.day;
//
//     String hijriDate = '$hijriDay ${getHijriMonthName(hijriMonth)} $hijriYear';
//     String time = DateFormat('hh:mm a', 'ar').format(dateTime);
//
//     switch (mode) {
//       case DateTimeMode.date:
//         return hijriDate;
//       case DateTimeMode.time:
//         return time;
//       case DateTimeMode.both:
//         return '$hijriDate – $time';
//     }
//   }
//
//   static String getHijriMonthName(int month) {
//     const hijriMonths = [
//       'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر', 'جمادى الأولى', 'جمادى الآخرة',
//       'رجب', 'شعبان', 'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
//     ];
//     return hijriMonths[month - 1];
//   }
//
//   static DateTime parseDateTime(String dateTimeString, DateTimeMode mode, CalendarType calendarType) {
//     if (calendarType == CalendarType.gregorian) {
//       switch (mode) {
//         case DateTimeMode.date:
//           return DateFormat('dd MMMM yyyy', 'ar').parse(dateTimeString);
//         case DateTimeMode.time:
//           return DateFormat('hh:mm a', 'ar').parse(dateTimeString);
//         case DateTimeMode.both:
//           var parts = dateTimeString.split(' – ');
//           var datePart = parts[0];
//           var timePart = parts.length > 1 ? parts[1] : '';
//           var date = DateFormat('dd MMMM yyyy', 'ar').parse(datePart);
//           var time = timePart.isNotEmpty ? DateFormat('hh:mm a', 'ar').parse(timePart) : DateTime(0);
//           return DateTime(date.year, date.month, date.day, time.hour, time.minute);
//       }
//     } else {
//       final parts = dateTimeString.split(' – ')[0].split(' ');
//       final hijriDay = int.parse(parts[0]);
//       final hijriMonth = getHijriMonthNumber(parts[1]);
//       final hijriYear = int.parse(parts[2]);
//
//       final gregorianYear = hijriYear - 622 + (hijriMonth > 2 ? 1 : 0);
//       final gregorianMonth = (hijriMonth + 2) % 12 + 1;
//       final gregorianDay = hijriDay;
//
//       final gregorianDate = DateTime(gregorianYear, gregorianMonth, gregorianDay);
//       final timeString = mode == DateTimeMode.both ? dateTimeString.split(' – ')[1] : dateTimeString;
//       final time = DateFormat('hh:mm a', 'ar').parse(timeString);
//
//       return DateTime(gregorianYear, gregorianMonth, gregorianDay, time.hour, time.minute);
//     }
//   }
//
//   static int getHijriMonthNumber(String monthName) {
//     const hijriMonths = {
//       'محرم': 1, 'صفر': 2, 'ربيع الأول': 3, 'ربيع الآخر': 4,
//       'جمادى الأولى': 5, 'جمادى الآخرة': 6, 'رجب': 7, 'شعبان': 8,
//       'رمضان': 9, 'شوال': 10, 'ذو القعدة': 11, 'ذو الحجة': 12
//     };
//     return hijriMonths[monthName]!;
//   }
//
//   static String convertToDisplayString(DateTime dateTime, CalendarType calendarType) {
//     if (calendarType == CalendarType.gregorian) {
//       return DateFormat('dd MMMM yyyy – hh:mm a', 'ar').format(dateTime);
//     } else {
//       return formatHijriDate(dateTime, DateTimeMode.both);
//     }
//   }
// }

// import 'package:intl/intl.dart';
//
// enum DateTimeMode { date, time, both }
// enum CalendarType { gregorian, hijri }
// enum DateDisplayFormat { numeric, named }
//
// class DateTimeUtils {
//   static String formatDateTime(DateTime dateTime, DateTimeMode mode, CalendarType calendarType, DateDisplayFormat format) {
//     if (calendarType == CalendarType.gregorian) {
//       switch (mode) {
//         case DateTimeMode.date:
//           return format == DateDisplayFormat.named
//               ? DateFormat('dd MMMM yyyy', 'ar').format(dateTime)
//               : DateFormat('dd/MM/yyyy', 'ar').format(dateTime);
//         case DateTimeMode.time:
//           return DateFormat('hh:mm a', 'ar').format(dateTime);
//         case DateTimeMode.both:
//           return format == DateDisplayFormat.named
//               ? '${DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}'
//               : '${DateFormat('dd/MM/yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}';
//       }
//     } else {
//       return formatHijriDate(dateTime, mode, format);
//     }
//   }
//
//   static String formatHijriDate(DateTime dateTime, DateTimeMode mode, DateDisplayFormat format) {
//     final hijriYear = dateTime.year + 622 - (dateTime.month > 2 ? 1 : 0);
//     final hijriMonth = (dateTime.month + 9) % 12 + 1;
//     final hijriDay = dateTime.day;
//
//     String hijriDate = format == DateDisplayFormat.named
//         ? '$hijriDay ${getHijriMonthName(hijriMonth)} $hijriYear'
//         : '$hijriDay/${hijriMonth.toString().padLeft(2, '0')}/$hijriYear';
//     String time = DateFormat('hh:mm a', 'ar').format(dateTime);
//
//     switch (mode) {
//       case DateTimeMode.date:
//         return hijriDate;
//       case DateTimeMode.time:
//         return time;
//       case DateTimeMode.both:
//         return '$hijriDate – $time';
//     }
//   }
//
//   static String getHijriMonthName(int month) {
//     const hijriMonths = [
//       'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر', 'جمادى الأولى', 'جمادى الآخرة',
//       'رجب', 'شعبان', 'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
//     ];
//     return hijriMonths[month - 1];
//   }
//
//   static DateTime parseDateTime(String dateTimeString, DateTimeMode mode, CalendarType calendarType) {
//     if (calendarType == CalendarType.gregorian) {
//       switch (mode) {
//         case DateTimeMode.date:
//           return DateFormat('dd MMMM yyyy', 'ar').parse(dateTimeString);
//         case DateTimeMode.time:
//           return DateFormat('hh:mm a', 'ar').parse(dateTimeString);
//         case DateTimeMode.both:
//           var parts = dateTimeString.split(' – ');
//           var datePart = parts[0];
//           var timePart = parts.length > 1 ? parts[1] : '';
//           var date = DateFormat('dd MMMM yyyy', 'ar').parse(datePart);
//           var time = timePart.isNotEmpty ? DateFormat('hh:mm a', 'ar').parse(timePart) : DateTime(0);
//           return DateTime(date.year, date.month, date.day, time.hour, time.minute);
//       }
//     } else {
//       final parts = dateTimeString.split(' – ')[0].split(' ');
//       final hijriDay = int.parse(parts[0]);
//       final hijriMonth = getHijriMonthNumber(parts[1]);
//       final hijriYear = int.parse(parts[2]);
//
//       final gregorianYear = hijriYear - 622 + (hijriMonth > 2 ? 1 : 0);
//       final gregorianMonth = (hijriMonth + 2) % 12 + 1;
//       final gregorianDay = hijriDay;
//
//       final gregorianDate = DateTime(gregorianYear, gregorianMonth, gregorianDay);
//       final timeString = mode == DateTimeMode.both ? dateTimeString.split(' – ')[1] : dateTimeString;
//       final time = DateFormat('hh:mm a', 'ar').parse(timeString);
//
//       return DateTime(gregorianYear, gregorianMonth, gregorianDay, time.hour, time.minute);
//     }
//   }
//
//   static int getHijriMonthNumber(String monthName) {
//     const hijriMonths = {
//       'محرم': 1, 'صفر': 2, 'ربيع الأول': 3, 'ربيع الآخر': 4,
//       'جمادى الأولى': 5, 'جمادى الآخرة': 6, 'رجب': 7, 'شعبان': 8,
//       'رمضان': 9, 'شوال': 10, 'ذو القعدة': 11, 'ذو الحجة': 12
//     };
//     return hijriMonths[monthName]!;
//   }
//
//   static String convertToDisplayString(DateTime dateTime, CalendarType calendarType, DateDisplayFormat format) {
//     if (calendarType == CalendarType.gregorian) {
//       return format == DateDisplayFormat.named
//           ? DateFormat('dd MMMM yyyy – hh:mm a', 'ar').format(dateTime)
//           : DateFormat('dd/MM/yyyy – hh:mm a', 'ar').format(dateTime);
//     } else {
//       return formatHijriDate(dateTime, DateTimeMode.both, format);
//     }
//   }
// }
