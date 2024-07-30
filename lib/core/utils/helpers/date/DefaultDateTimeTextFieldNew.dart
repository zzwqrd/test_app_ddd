import 'package:flutter/material.dart';

import 'DateTimeUtils.dart';

class DefaultDateTimeTextFieldNew extends StatefulWidget {
  final DateTime? initDate;
  final String? label, helperText, initialValue, headerTitle;
  final TextEditingController? controller;
  final bool? enabled, isLoading, isRequired;
  final IconData? icon, suffixIcon;
  final String Function(String?)? validator;
  final bool? borderLess;
  final Function(DateTime date) onDateTimeChange;
  final DateTimeMode mode;
  final CalendarType calendarType;

  const DefaultDateTimeTextFieldNew({
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
    this.mode = DateTimeMode.both,
    this.calendarType = CalendarType.gregorian,
  }) : super(key: key);

  @override
  _DefaultDateTimeTextFieldNewState createState() =>
      _DefaultDateTimeTextFieldNewState();
}

class _DefaultDateTimeTextFieldNewState
    extends State<DefaultDateTimeTextFieldNew>
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
        _controller.text = DateTimeUtils.formatDateTime(
            widget.initDate!, widget.mode, widget.calendarType);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void selectNewDate() async {
    DateTime? pickedDate;
    if (widget.mode == DateTimeMode.both || widget.mode == DateTimeMode.date) {
      pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDateTime ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: widget.calendarType == CalendarType.hijri
            ? const Locale('ar', 'SA')
            : const Locale('en', 'US'),
      );
    }

    TimeOfDay? pickedTime;
    if (widget.mode == DateTimeMode.both || widget.mode == DateTimeMode.time) {
      pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
    }

    if (pickedDate != null || pickedTime != null) {
      DateTime finalDateTime = DateTime(
        pickedDate?.year ?? _selectedDateTime?.year ?? DateTime.now().year,
        pickedDate?.month ?? _selectedDateTime?.month ?? DateTime.now().month,
        pickedDate?.day ?? _selectedDateTime?.day ?? DateTime.now().day,
        pickedTime?.hour ?? _selectedDateTime?.hour ?? DateTime.now().hour,
        pickedTime?.minute ??
            _selectedDateTime?.minute ??
            DateTime.now().minute,
      );
      setState(() {
        _selectedDateTime = finalDateTime;
      });
      widget.onDateTimeChange(finalDateTime);
      _controller.text = DateTimeUtils.formatDateTime(
          finalDateTime, widget.mode, widget.calendarType);
    }
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
