import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? dateTimeTh(DateTime? date) {
  if (date == null) {
    return null;
  }

  final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm:ss', 'th_TH');
  final buddhistYear = date.year + 543;
  return formatter.format(date).replaceFirst('${date.year}', '$buddhistYear');
}

String? dateTh(DateTime? date) {
  if (date == null) {
    return null;
  }
  final DateFormat formatter = DateFormat('d MMMM yyyy', 'th_TH');
  final buddhistYear = date.year + 543;
  return formatter.format(date).replaceFirst('${date.year}', '$buddhistYear');
}

DateTime getDateByMonthAndYear(
  String month,
  String year,
) {
  DateTime currentDate = DateTime.now();
  return DateTime((int.parse(year) - 543), int.parse(month), currentDate.day);
}

DateTime getEndDayTime(DateTime currentDate) {
  DateTime endOfDay = DateTime(
      currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
  return endOfDay;
}

DateTime getFirstDayOfMonth(DateTime date) {
  DateTime firstDayOfCurrentMonth = DateTime(date.year, date.month, 1);
  return firstDayOfCurrentMonth;
}

DateTime getLastDayOfMonth(DateTime date) {
  DateTime firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
  DateTime lastDayOfCurrentMonth =
      firstDayOfNextMonth.subtract(Duration(seconds: 1));
  return lastDayOfCurrentMonth;
}

DateTime getNextDay(
  int nextDay,
  DateTime dateTime,
) {
  DateTime newDate = dateTime.add(Duration(days: nextDay));
  return DateTime(newDate.year, newDate.month, newDate.day);
}

DateTime getStartDayTime(DateTime currentDate) {
  DateTime startOfDay =
      DateTime(currentDate.year, currentDate.month, currentDate.day);
  return startOfDay;
}

List<String> getYearFromCurrent(int len) {
  List<String> yearList = [];
  int currentYear = DateTime.now().year + 543;
  for (var i = currentYear - len; i <= currentYear; i++) {
    yearList.add(i.toString());
  }
  return yearList;
}

Color getColorStatus(String status) {
  switch (status) {
    case "ใช้งานอยู่":
      return const Color(0xFF4CAF50); // สีเขียว (สำหรับสถานะ "ใช้งานอยู่")
    case "ส่งซ่อม":
      return const Color(0xFFFF9800); // สีส้ม (สำหรับสถานะ "ส่งซ่อม")
    case "ว่าง":
      return const Color(0xFF2196F3); // สีน้ำเงิน (สำหรับสถานะ "ว่าง")
    case "ใช้ไม่ได้แล้ว":
      return const Color(0xFFF44336); // สีแดง (สำหรับสถานะ "ใช้ไม่ได้แล้ว")
    case "หาย":
      return const Color(0xFFF44336); // สีแดง (สำหรับสถานะ "หาย")
    default:
      return const Color(0xFF000000); // สีดำ (สถานะไม่รู้จัก)
  }
}

int stringToInt(String? str) {
  if (str == null) {
    return 0;
  }

  return int.parse(str);
}
