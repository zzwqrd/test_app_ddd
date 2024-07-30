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
