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

Future<AssetListRecord?> getAssetDataFromID(String? assetID) async {
  // Add your function code here!
  if (assetID == null) {
    return null;
  }
  var rs = await FirebaseFirestore.instance
      .doc("${FFAppState().customerData.customerRef}/asset_list/$assetID")
      .get();
  if (!rs.exists) {
    return null;
  }
  AssetListRecord tmp =
      AssetListRecord.getDocumentFromData(rs.data()!, rs.reference);

  return tmp;
}