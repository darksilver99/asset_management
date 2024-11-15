import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

getSaveAndGetImagePath(WidgetsToImageController controller) async {
  print("getSaveAndGetImagePath");

  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    if (int.parse(info.version.release) >= 13) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return getSaveAndGetImagePath(controller);
      }
    }
  }

  final bytes = await controller.capture();
  final result = await ImageGallerySaver.saveImage(bytes!);
  print(result["filePath"]);
}
