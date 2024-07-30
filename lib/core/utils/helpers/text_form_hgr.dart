// import 'package:flutter/material.dart';
// import 'package:ummalqura_calendar/ummalqura_calendar.dart';
// import 'package:intl/intl.dart';
//
// enum DateTimeMode { date, time, both }
// enum CalendarType { gregorian, hijri }
//
// class DefaultDateTimeTextField extends StatefulWidget {
//   final DateTime? initDate;
//   final String? label, helperText, initialValue, headerTitle;
//   final TextEditingController? controller;
//   final bool? enabled, isLoading, isRequired;
//   final IconData? icon, suffixIcon;
//   final String Function(String?)? validator;
//   final bool? borderLess;
//   final Function(DateTime date) onDateTimeChange;
//   final DateTimeMode mode;
//   final CalendarType calendarType;
//
//   const DefaultDateTimeTextField({
//     Key? key,
//     this.icon,
//     required this.onDateTimeChange,
//     this.initDate,
//     this.label,
//     this.controller,
//     this.isLoading = false,
//     this.isRequired = false,
//     this.helperText,
//     this.suffixIcon = Icons.access_time,
//     this.validator,
//     this.borderLess = false,
//     this.enabled = true,
//     this.initialValue,
//     this.headerTitle,
//     this.mode = DateTimeMode.both,
//     this.calendarType = CalendarType.gregorian,
//   }) : super(key: key);
//
//   @override
//   _DefaultDateTimeTextFieldState createState() => _DefaultDateTimeTextFieldState();
// }
//
// class _DefaultDateTimeTextFieldState extends State<DefaultDateTimeTextField> with DefaultDecoration, DateTimePickerMixin {
//   final FocusNode _focusNode = FocusNode();
//   TextEditingController _controller = TextEditingController();
//   DateTime? _selectedDateTime;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() => setState(() {}));
//     if (widget.controller != null) _controller = widget.controller!;
//     if (widget.initDate != null) {
//       _selectedDateTime = widget.initDate;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _controller.text = _formatDateTime(widget.initDate!);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   void selectNewDate() async {
//     DateTime? pickedDate;
//     if (widget.mode == DateTimeMode.both || widget.mode == DateTimeMode.date) {
//       if (widget.calendarType == CalendarType.gregorian) {
//         pickedDate = await showDatePicker(
//           context: context,
//           initialDate: _selectedDateTime ?? DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );
//       } else {
//         pickedDate = await showHijriDatePicker(context, _selectedDateTime);
//       }
//     }
//
//     TimeOfDay? pickedTime;
//     if (widget.mode == DateTimeMode.both || widget.mode == DateTimeMode.time) {
//       pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
//       );
//     }
//
//     if (pickedDate != null || pickedTime != null) {
//       DateTime finalDateTime = DateTime(
//         pickedDate?.year ?? _selectedDateTime?.year ?? DateTime.now().year,
//         pickedDate?.month ?? _selectedDateTime?.month ?? DateTime.now().month,
//         pickedDate?.day ?? _selectedDateTime?.day ?? DateTime.now().day,
//         pickedTime?.hour ?? _selectedDateTime?.hour ?? DateTime.now().hour,
//         pickedTime?.minute ?? _selectedDateTime?.minute ?? DateTime.now().minute,
//       );
//       setState(() {
//         _selectedDateTime = finalDateTime;
//       });
//       widget.onDateTimeChange(finalDateTime);
//       _controller.text = _formatDateTime(finalDateTime);
//     }
//   }
//
//   Future<DateTime?> showHijriDatePicker(BuildContext context, DateTime? initialDate) async {
//     UmmAlquraCalendar ummAlquraCalendar = UmmAlquraCalendar.now();
//     if (initialDate != null) {
//       ummAlquraCalendar = UmmAlquraCalendar.fromDate(initialDate);
//     }
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: ummAlquraCalendar.toDate(),
//       firstDate: UmmAlquraCalendar(1356, 1, 1).toDate(),
//       lastDate: UmmAlquraCalendar(1500, 12, 30).toDate(),
//     );
//     if (pickedDate != null) {
//       return UmmAlquraCalendar.fromDate(pickedDate).toDate();
//     }
//     return null;
//   }
//
//   String _formatDateTime(DateTime dateTime) {
//     if (widget.calendarType == CalendarType.gregorian) {
//       return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
//     } else {
//       UmmAlquraCalendar ummAlquraCalendar = UmmAlquraCalendar.fromDate(dateTime);
//       return "${ummAlquraCalendar.fullDate()} – ${DateFormat('kk:mm').format(dateTime)}";
//     }
//   }
//
//   void resetDateTime() {
//     setState(() {
//       _selectedDateTime = null;
//       _controller.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.headerTitle != null)
//           IsRequiredView(
//               title: widget.headerTitle ?? '',
//               isRequired: widget.isRequired ?? false),
//         if (widget.headerTitle != null)
//           const SizedBox(
//             height: 10,
//           ),
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             TextFormField(
//               focusNode: _focusNode,
//               onTap: selectNewDate,
//               controller: _controller,
//               style: textTheme.titleMedium,
//               readOnly: true,
//               decoration: textFiledDecoration(
//                   widget.icon, widget.label, widget.borderLess)
//                   .copyWith(
//                 filled: true,
//                 fillColor: colorScheme.surface,
//                 suffixIcon: _suffixView(context),
//                 helperText: widget.helperText,
//                 helperMaxLines: 6,
//                 helperStyle: textTheme.bodySmall
//                     ?.copyWith(color: colorScheme.onSecondary),
//                 errorMaxLines: 2,
//               ),
//               validator: widget.validator,
//               enabled: widget.enabled,
//             ),
//             if (_selectedDateTime != null)
//               Positioned(
//                 right: 0,
//                 child: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: resetDateTime,
//                 ),
//               ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget? _suffixView(BuildContext context) {
//     if (widget.suffixIcon == null) return null;
//     return Icon(widget.suffixIcon, color: Theme.of(context).iconTheme.color);
//   }
// }
//
// mixin DefaultDecoration {
//   InputDecoration textFiledDecoration(
//       IconData? icon, String? label, bool? borderLess) {
//     return InputDecoration(
//       icon: icon != null ? Icon(icon) : null,
//       labelText: label,
//       border: borderLess ?? false ? InputBorder.none : UnderlineInputBorder(),
//     );
//   }
// }
//
// mixin DateTimePickerMixin {}
//
// class IsRequiredView extends StatelessWidget {
//   final String title;
//   final bool isRequired;
//
//   const IsRequiredView({
//     Key? key,
//     required this.title,
//     this.isRequired = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         if (isRequired)
//           Text(
//             ' *',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//       ],
//     );
//   }
// }
/// التاريخ ما بين ميلادي وهجري

// DefaultDateTimeTextField(
// onDateTimeChange: (DateTime dateTime) {
// setState(() {
// selectedDateTime = dateTime;
// });
// },
// initDate: DateTime.now(),
// label: "Select Date and Time",
// helperText: "Tap to select date and time",
// icon: Icons.calendar_today,
// suffixIcon: Icons.access_time,
// mode: DateTimeMode.both, // حدد الوضع هنا
// calendarType: CalendarType.gregorian, // حدد نوع التقويم هنا
// ),
