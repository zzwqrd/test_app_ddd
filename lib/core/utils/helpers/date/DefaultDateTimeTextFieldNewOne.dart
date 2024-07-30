import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DefaultDateTimeTextFieldNewOne extends StatefulWidget {
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
  final DateDisplayFormat dateDisplayFormat;

  const DefaultDateTimeTextFieldNewOne({
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
    this.dateDisplayFormat = DateDisplayFormat.named,
  }) : super(key: key);

  @override
  _DefaultDateTimeTextFieldNewOneState createState() =>
      _DefaultDateTimeTextFieldNewOneState();
}

class _DefaultDateTimeTextFieldNewOneState
    extends State<DefaultDateTimeTextFieldNewOne>
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
        _controller.text = DateTimeUtils.formatDateTime(widget.initDate!,
            widget.mode, widget.calendarType, widget.dateDisplayFormat);
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
      _controller.text = DateTimeUtils.formatDateTime(finalDateTime,
          widget.mode, widget.calendarType, widget.dateDisplayFormat);
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

enum DateTimeMode { date, time, both }

enum CalendarType { gregorian, hijri }

enum DateDisplayFormat { numeric, named }

class DateTimeUtils {
  static String formatDateTime(DateTime dateTime, DateTimeMode mode,
      CalendarType calendarType, DateDisplayFormat format) {
    if (calendarType == CalendarType.gregorian) {
      switch (mode) {
        case DateTimeMode.date:
          return format == DateDisplayFormat.named
              ? DateFormat('dd MMMM yyyy', 'ar').format(dateTime)
              : DateFormat('dd/MM/yyyy', 'ar').format(dateTime);
        case DateTimeMode.time:
          return DateFormat('hh:mm a', 'ar').format(dateTime);
        case DateTimeMode.both:
          return format == DateDisplayFormat.named
              ? '${DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}'
              : '${DateFormat('dd/MM/yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}';
      }
    } else {
      return formatHijriDate(dateTime, mode, format);
    }
  }

  static String formatHijriDate(
      DateTime dateTime, DateTimeMode mode, DateDisplayFormat format) {
    final hijriYear = dateTime.year + 622 - (dateTime.month > 2 ? 1 : 0);
    final hijriMonth = (dateTime.month + 9) % 12 + 1;
    final hijriDay = dateTime.day;

    String hijriDate = format == DateDisplayFormat.named
        ? '$hijriDay ${getHijriMonthName(hijriMonth)} $hijriYear'
        : '$hijriDay/${hijriMonth.toString().padLeft(2, '0')}/$hijriYear';
    String time = DateFormat('hh:mm a', 'ar').format(dateTime);

    switch (mode) {
      case DateTimeMode.date:
        return hijriDate;
      case DateTimeMode.time:
        return time;
      case DateTimeMode.both:
        return '$hijriDate – $time';
    }
  }

  static String getHijriMonthName(int month) {
    const hijriMonths = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة'
    ];
    return hijriMonths[month - 1];
  }

  static DateTime parseDateTime(
      String dateTimeString, DateTimeMode mode, CalendarType calendarType) {
    if (calendarType == CalendarType.gregorian) {
      switch (mode) {
        case DateTimeMode.date:
          return DateFormat('dd MMMM yyyy', 'ar').parse(dateTimeString);
        case DateTimeMode.time:
          return DateFormat('hh:mm a', 'ar').parse(dateTimeString);
        case DateTimeMode.both:
          var parts = dateTimeString.split(' – ');
          var datePart = parts[0];
          var timePart = parts.length > 1 ? parts[1] : '';
          var date = DateFormat('dd MMMM yyyy', 'ar').parse(datePart);
          var time = timePart.isNotEmpty
              ? DateFormat('hh:mm a', 'ar').parse(timePart)
              : DateTime(0);
          return DateTime(
              date.year, date.month, date.day, time.hour, time.minute);
      }
    } else {
      final parts = dateTimeString.split(' – ')[0].split(' ');
      final hijriDay = int.parse(parts[0]);
      final hijriMonth = getHijriMonthNumber(parts[1]);
      final hijriYear = int.parse(parts[2]);

      final gregorianYear = hijriYear - 622 + (hijriMonth > 2 ? 1 : 0);
      final gregorianMonth = (hijriMonth + 2) % 12 + 1;
      final gregorianDay = hijriDay;

      final gregorianDate =
          DateTime(gregorianYear, gregorianMonth, gregorianDay);
      final timeString = mode == DateTimeMode.both
          ? dateTimeString.split(' – ')[1]
          : dateTimeString;
      final time = DateFormat('hh:mm a', 'ar').parse(timeString);

      return DateTime(
          gregorianYear, gregorianMonth, gregorianDay, time.hour, time.minute);
    }
  }

  static int getHijriMonthNumber(String monthName) {
    const hijriMonths = {
      'محرم': 1,
      'صفر': 2,
      'ربيع الأول': 3,
      'ربيع الآخر': 4,
      'جمادى الأولى': 5,
      'جمادى الآخرة': 6,
      'رجب': 7,
      'شعبان': 8,
      'رمضان': 9,
      'شوال': 10,
      'ذو القعدة': 11,
      'ذو الحجة': 12
    };
    return hijriMonths[monthName]!;
  }

  static String convertToDisplayString(
      DateTime dateTime, CalendarType calendarType, DateDisplayFormat format) {
    if (calendarType == CalendarType.gregorian) {
      return format == DateDisplayFormat.named
          ? DateFormat('dd MMMM yyyy – hh:mm a', 'ar').format(dateTime)
          : DateFormat('dd/MM/yyyy – hh:mm a', 'ar').format(dateTime);
    } else {
      return formatHijriDate(dateTime, DateTimeMode.both, format);
    }
  }
}
