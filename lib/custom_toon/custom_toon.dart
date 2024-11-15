import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

Future<String?> getSaveAndGetImagePath(WidgetsToImageController controller) async {
  final bytes = await controller.capture();
  String base64Image = base64Encode(bytes!);

  final Directory tempDir = await getTemporaryDirectory();
  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  final String tempPath = '${tempDir.path}/qr_code_$timestamp.png';
  await File(tempPath).writeAsBytes(base64Decode(base64Image));

  return tempPath;
}
