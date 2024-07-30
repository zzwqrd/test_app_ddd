// date_time_formatter.dart

import 'package:intl/intl.dart';

class DateTimeFormatter {
  // تحويل DateTime إلى سلسلة بتنسيق معين
  static String format(DateTime dateTime,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  // تحويل التاريخ الحالي إلى سلسلة بتنسيق معين
  // static String formatNow({String format = 'yyyy-MM-dd HH:mm:ss'}) {
  //   final DateTime now = DateTime.now();
  //   return format(now, format: format); // يجب استدعاء الميثود format هنا
  // }

  // تحويل DateTime إلى سلسلة بتنسيق منطقي مثل 'قبل 5 دقائق'
  static String timeAgoSinceDate(DateTime dateTime,
      {bool numericDates = true}) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 8) {
      return format(dateTime);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'قبل أسبوع' : 'الأسبوع الماضي';
    } else if (difference.inDays >= 2) {
      return 'قبل ${difference.inDays} أيام';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'قبل يوم' : 'أمس';
    } else if (difference.inHours >= 2) {
      return 'قبل ${difference.inHours} ساعات';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'قبل ساعة' : 'ساعة مضت';
    } else if (difference.inMinutes >= 2) {
      return 'قبل ${difference.inMinutes} دقائق';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'قبل دقيقة' : 'دقيقة مضت';
    } else if (difference.inSeconds >= 3) {
      return 'قبل ${difference.inSeconds} ثواني';
    } else {
      return 'الآن';
    }
  }

  // تحويل سلسلة تاريخ بتنسيق معين إلى DateTime
  static DateTime parse(String dateString,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.parse(dateString);
  }
}
