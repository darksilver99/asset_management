// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:excel/excel.dart';
import 'package:excel/excel.dart' as exBorder;
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;

Future<String> exportExcel2() async {
  // Add your function code here!
  bool isGranted = false;
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    if (int.parse(info.version.release) >= 13) {
      isGranted = true;
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        isGranted = true;
      }
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      isGranted = true;
    }
  }

  if (!isGranted) {
    return '';
  }

  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  CellStyle cellStyle = CellStyle(
    backgroundColorHex: ExcelColor.fromHexString("#1AFF1A"),
    horizontalAlign: HorizontalAlign.Center,
    bold: true,
    leftBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    rightBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    topBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    bottomBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
  );

// title
  var cell =
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
  cell.value = TextCellValue(
      'รายงานค่าใข้จ่าย ข้อมูลวันที่ ${functions.dateTh(getCurrentTimestamp)}');
  cell.cellStyle = CellStyle(fontSize: 22, bold: true);

  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1))
    ..value = TextCellValue("รายการอุปกรณ์")
    ..cellStyle = CellStyle(fontSize: 22, bold: true);

// สร้างหัวตารางสำหรับอุปกรณ์ทั้งหมด
  List<String> header = [
    "ชื่ออุปกรณ์",
    "วันที่ซื้อ",
    "ราคา",
  ];
  for (var i = 0; i < header.length; i++) {
    var cell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 2));
    cell.value = TextCellValue(header[i]);
    cell.cellStyle = cellStyle;
  }

// body
  QuerySnapshot<Map<String, dynamic>> dataList = await FirebaseFirestore
      .instance
      .collection("${FFAppState().customerData.customerRef!.path}/asset_list")
      .orderBy("purchase_date", descending: true)
      .get();

  if (dataList.size == 0) {
    return "No Data";
  }

  double totalPrice = 0.0; // ตัวแปรสำหรับเก็บผลรวมราคา

// เพิ่มข้อมูลอุปกรณ์ทั้งหมด
  for (int i = 0; i < dataList.size; i++) {
    var dataRecord = dataList.docs[i].data();

    // Set each value in the corresponding column
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 3))
      ..value = TextCellValue(
          "${dataRecord["subject"]}(${dataRecord["serial_number"]})")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 3))
      ..value = TextCellValue(
          "${functions.dateTh(dataRecord["purchase_date"].toDate())}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

    double price =
        double.tryParse("${dataRecord["price"]}") ?? 0.0; // แปลงเป็น double
    totalPrice += price; // เพิ่มราคานี้เข้าไปในผลรวม

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 3))
      ..value = TextCellValue(" ${dataRecord["price"]}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);
  }

// สไตล์สำหรับแถวรวม
  CellStyle totalRowStyle = CellStyle(
    backgroundColorHex: ExcelColor.fromHexString("#FFFF99"), // สีเหลืองอ่อน
    bold: true,
    horizontalAlign: HorizontalAlign.Right,
  );

// เพิ่มข้อมูลรวมที่แถวสุดท้ายของอุปกรณ์ทั้งหมด
  int lastRowIndex = dataList.size + 3; // แถวใหม่หลังจากข้อมูลทั้งหมด

  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: lastRowIndex))
    ..value = TextCellValue("รวมราคาอุปกรณ์")
    ..cellStyle =
        totalRowStyle.copyWith(horizontalAlignVal: HorizontalAlign.Left);

  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: lastRowIndex))
    ..value = TextCellValue("")
    ..cellStyle = totalRowStyle;

  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: lastRowIndex))
    ..value = TextCellValue(totalPrice.toStringAsFixed(2))
    ..cellStyle = totalRowStyle;

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // เพิ่มตารางรายการซ่อม
  int repairTableStartRow =
      lastRowIndex + 3; // แถวที่เริ่มต้นของตารางรายการซ่อม

  sheetObject.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: repairTableStartRow))
    ..value = TextCellValue("รายการซ่อม")
    ..cellStyle = CellStyle(fontSize: 22, bold: true);

// สร้างหัวตารางรายการซ่อม
  List<String> repairHeader = ["ชื่ออุปกรณ์", "วันที่เสร็จสิ้น", "ราคาซ่อม"];
  for (var i = 0; i < repairHeader.length; i++) {
    var cell = sheetObject.cell(CellIndex.indexByColumnRow(
        columnIndex: i, rowIndex: repairTableStartRow + 1));
    cell.value = TextCellValue(repairHeader[i]);
    cell.cellStyle = cellStyle;
  }

  double totalRepairPrice = 0.0; // ตัวแปรสำหรับเก็บผลรวมราคาซ่อม
  int totalRepairRows = 0; // ตัวแปรสำหรับเก็บจำนวนแถวการซ่อมทั้งหมด

  List<Map<String, dynamic>> tmpDate = [];

// ค้นหาข้อมูลการซ่อมจาก Firestore
  for (int i = 0; i < dataList.size; i++) {
    var dataRecord = dataList.docs[i].data();
    var assetRef = dataList.docs[i].reference; // ค้นหาจาก asset reference

    if (!dataRecord.containsKey("last_repair_ref")) {
      continue;
    }

    // ค้นหาข้อมูลการซ่อมที่เกี่ยวข้อง
    QuerySnapshot<Map<String, dynamic>> repairList = await FirebaseFirestore
        .instance
        .collection(
            "${FFAppState().customerData.customerRef!.path}/repair_list")
        .where("asset_ref", isEqualTo: assetRef)
        .get();

    // แสดงรายการซ่อม
    for (int j = 0; j < repairList.size; j++) {
      var repairRecord = repairList.docs[j].data();
      repairRecord["name"] =
          "${dataRecord["subject"]}(${dataRecord["serial_number"]})";
      tmpDate.add(repairRecord);
    }
  }

  tmpDate.sort((a, b) {
    // ตรวจสอบว่า finish_date ของ a และ b เป็น null หรือไม่
    if (a["finish_date"] == null && b["finish_date"] != null) {
      return -1; // ให้ a อยู่บนสุด
    } else if (a["finish_date"] != null && b["finish_date"] == null) {
      return 1; // ให้ b อยู่บนสุด
    }

    // เปรียบเทียบ finish_date โดยแปลงเป็น DateTime หากเป็น Timestamp
    DateTime aDate = (a["finish_date"] as Timestamp?)?.toDate() ??
        DateTime(0); // กำหนดค่าเริ่มต้นให้เป็น DateTime(0) ถ้าเป็น null
    DateTime bDate = (b["finish_date"] as Timestamp?)?.toDate() ??
        DateTime(0); // กำหนดค่าเริ่มต้นให้เป็น DateTime(0) ถ้าเป็น null

    return bDate.compareTo(aDate); // เปรียบเทียบจากใหม่ไปเก่า
  });

  for (int j = 0; j < tmpDate.length; j++) {
    // ชื่ออุปกรณ์
    sheetObject.cell(CellIndex.indexByColumnRow(
        columnIndex: 0, rowIndex: repairTableStartRow + 2 + totalRepairRows))
      ..value = TextCellValue("${tmpDate[j]["name"]}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);

    if (tmpDate[j]["finish_date"] == null) {
      // วันที่ซ่อม
      sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: 1, rowIndex: repairTableStartRow + 2 + totalRepairRows))
        ..value = TextCellValue("-")
        ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      // ราคาซ่อม
      sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: 2, rowIndex: repairTableStartRow + 2 + totalRepairRows))
        ..value = TextCellValue("กำลังซ่อม")
        ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);
    } else {
      // ราคาซ่อม
      double repairPrice = double.tryParse("${tmpDate[j]["price"]}") ?? 0.0;
      totalRepairPrice += repairPrice; // เพิ่มราคาซ่อมเข้าไปในผลรวม

      // วันที่ซ่อม
      sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: 1, rowIndex: repairTableStartRow + 2 + totalRepairRows))
        ..value = TextCellValue(
            "${functions.dateTh(tmpDate[j]["finish_date"].toDate())}")
        ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      sheetObject.cell(CellIndex.indexByColumnRow(
          columnIndex: 2, rowIndex: repairTableStartRow + 2 + totalRepairRows))
        ..value = TextCellValue("${tmpDate[j]["price"]}")
        ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);
    }
    totalRepairRows++; // เพิ่มจำนวนแถวการซ่อมทั้งหมด
  }

// สไตล์สำหรับแถวรวมการซ่อม
  CellStyle repairTotalRowStyle = CellStyle(
    backgroundColorHex: ExcelColor.fromHexString("#FFFF99"), // สีเหลืองอ่อน
    bold: true,
    horizontalAlign: HorizontalAlign.Right,
  );

  // เพิ่มข้อมูลรวมการซ่อมที่แถวสุดท้ายของรายการซ่อม
  int repairLastRowIndex =
      repairTableStartRow + 2 + totalRepairRows; // ใช้ totalRepairRows แทน

  sheetObject.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: repairLastRowIndex))
    ..value = TextCellValue("รวมราคาซ่อม")
    ..cellStyle =
        repairTotalRowStyle.copyWith(horizontalAlignVal: HorizontalAlign.Left);

  sheetObject.cell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: repairLastRowIndex))
    ..value = TextCellValue("")
    ..cellStyle = repairTotalRowStyle;

  sheetObject.cell(
      CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: repairLastRowIndex))
    ..value = TextCellValue(totalRepairPrice.toStringAsFixed(2))
    ..cellStyle = repairTotalRowStyle;

// ตารางสุดท้าย (รวมราคาอุปกรณ์และการซ่อม)
  int finalTotalRow = repairLastRowIndex + 2;
  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: finalTotalRow))
    ..value = TextCellValue("รวมทั้งหมด")
    ..cellStyle = CellStyle(fontSize: 22, bold: true);

  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: finalTotalRow))
    ..value = TextCellValue("")
    ..cellStyle = CellStyle();

  sheetObject
      .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: finalTotalRow))
    ..value = TextCellValue((totalPrice + totalRepairPrice).toStringAsFixed(2))
    ..cellStyle = totalRowStyle;

  // Auto-size columns
  for (int col = 0; col < header.length; col++) {
    sheetObject.setDefaultColumnWidth(30);
  }

  Directory dir = await getApplicationDocumentsDirectory();
  List<int>? fileBytes = excel.save();
  var path = File(
      '${dir.path}/รายงานค่าใข้จ่ายข้อมูลวันที่${functions.dateTh(getCurrentTimestamp)}.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  print(path);

  return path.path;
}
