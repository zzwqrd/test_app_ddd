import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لاستخدام التنسيق

class DefaultDateTimeTextField extends StatefulWidget {
  final DateTime? initDate;
  final String? label, helperText, initialValue, headerTitle;
  final TextEditingController? controller;
  final bool? enabled, isLoading, isRequired;
  final IconData? icon, suffixIcon;
  final String Function(String?)? validator;
  final bool? borderLess;
  final Function(DateTime date) onDateTimeChange;

  const DefaultDateTimeTextField({
    Key? key,
    this.icon,
    required this.onDateTimeChange,
    this.initDate,
    this.label,
    this.controller,
    this.isLoading = false,
    this.isRequired = false,
    this.helperText,
    this.suffixIcon = Icons.access_time,
    this.validator,
    this.borderLess = false,
    this.enabled = true,
    this.initialValue,
    this.headerTitle,
  }) : super(key: key);

  @override
  _DefaultDateTimeTextFieldState createState() =>
      _DefaultDateTimeTextFieldState();
}

class _DefaultDateTimeTextFieldState extends State<DefaultDateTimeTextField>
    with DefaultDecoration, DateTimePickerMixin {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
    if (widget.controller != null) _controller = widget.controller!;
    if (widget.initDate != null) {
      _selectedDateTime = widget.initDate;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = _formatDateTime(widget.initDate!);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void selectNewDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
        setState(() {
          _selectedDateTime = finalDateTime;
        });
        widget.onDateTimeChange(finalDateTime);
        _controller.text = _formatDateTime(finalDateTime);
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  void resetDateTime() {
    setState(() {
      _selectedDateTime = null;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerTitle != null)
          IsRequiredView(
              title: widget.headerTitle ?? '',
              isRequired: widget.isRequired ?? false),
        if (widget.headerTitle != null)
          const SizedBox(
            height: 10,
          ),
        Stack(
          alignment: Alignment.center,
          children: [
            TextFormField(
              focusNode: _focusNode,
              onTap: selectNewDate,
              controller: _controller,
              style: textTheme.titleMedium,
              readOnly: true,
              decoration: textFiledDecoration(
                      widget.icon, widget.label, widget.borderLess)
                  .copyWith(
                filled: true,
                fillColor: colorScheme.surface,
                suffixIcon: _suffixView(context),
                helperText: widget.helperText,
                helperMaxLines: 6,
                helperStyle: textTheme.bodySmall
                    ?.copyWith(color: colorScheme.onSecondary),
                errorMaxLines: 2,
              ),
              validator: widget.validator,
              enabled: widget.enabled,
            ),
            if (_selectedDateTime != null)
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: resetDateTime,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget? _suffixView(BuildContext context) {
    if (widget.suffixIcon == null) return null;
    return Icon(widget.suffixIcon, color: Theme.of(context).iconTheme.color);
  }
}

mixin DefaultDecoration {
  InputDecoration textFiledDecoration(
      IconData? icon, String? label, bool? borderLess) {
    return InputDecoration(
      icon: icon != null ? Icon(icon) : null,
      labelText: label,
      border: borderLess ?? false ? InputBorder.none : UnderlineInputBorder(),
    );
  }
}

mixin DateTimePickerMixin {}

class IsRequiredView extends StatelessWidget {
  final String title;
  final bool isRequired;

  const IsRequiredView({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isRequired)
          Text(
            ' *',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
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
//   }) : super(key: key);
//
//   @override
//   _DefaultDateTimeTextFieldState createState() =>
//       _DefaultDateTimeTextFieldState();
// }
//
// class _DefaultDateTimeTextFieldState extends State<DefaultDateTimeTextField>
//     with DefaultDecoration, DateTimePickerMixin {
//   final FocusNode _focusNode = FocusNode();
//   TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() => setState(() {}));
//     if (widget.controller != null) _controller = widget.controller!;
//     if (widget.initDate != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _controller.text = widget.initDate?.toIso8601String() ?? '';
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
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: widget.initDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (pickedDate != null) {
//       TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(widget.initDate ?? DateTime.now()),
//       );
//
//       if (pickedTime != null) {
//         DateTime finalDateTime = DateTime(pickedDate.year, pickedDate.month,
//             pickedDate.day, pickedTime.hour, pickedTime.minute);
//         widget.onDateTimeChange(finalDateTime);
//         _controller.text = finalDateTime.toIso8601String();
//       }
//     }
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
//                       widget.icon, widget.label, widget.borderLess)
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
