import 'package:intl/intl.dart';

enum DateTimeMode { date, time, both }

enum CalendarType { gregorian, hijri }

class DateTimeUtils {
  static String formatDateTime(
      DateTime dateTime, DateTimeMode mode, CalendarType calendarType) {
    if (calendarType == CalendarType.gregorian) {
      switch (mode) {
        case DateTimeMode.date:
          return DateFormat('dd MMMM yyyy', 'ar')
              .format(dateTime); // تنسيق التاريخ الميلادي باللغة العربية
        case DateTimeMode.time:
          return DateFormat('hh:mm a', 'ar')
              .format(dateTime); // تنسيق الوقت 12 ساعة باللغة العربية
        case DateTimeMode.both:
          return '${DateFormat('dd MMMM yyyy', 'ar').format(dateTime)} – ${DateFormat('hh:mm a', 'ar').format(dateTime)}';
      }
    } else {
      return formatHijriDate(dateTime, mode);
    }
  }

  static String formatHijriDate(DateTime dateTime, DateTimeMode mode) {
    // تحويل التاريخ الميلادي إلى هجري
    final hijriYear = dateTime.year + 622 - (dateTime.month > 2 ? 1 : 0);
    final hijriMonth = (dateTime.month + 9) % 12 + 1;
    final hijriDay = dateTime.day;

    String hijriDate = '$hijriDay ${getHijriMonthName(hijriMonth)} $hijriYear';
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
      // تحويل التاريخ الهجري إلى ميلادي
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
      DateTime dateTime, CalendarType calendarType) {
    if (calendarType == CalendarType.gregorian) {
      return DateFormat('dd MMMM yyyy – hh:mm a', 'ar').format(dateTime);
    } else {
      return formatHijriDate(dateTime, DateTimeMode.both);
    }
  }
}
