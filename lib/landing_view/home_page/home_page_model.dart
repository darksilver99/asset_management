import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/component/expire_alert_view/expire_alert_view_widget.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - checkIsExpire] action in Button widget.
  bool? isExpire;
  var qrCode = '';
  // Stores action output result for [Custom Action - getAssetData] action in Button widget.
  AssetListRecord? assetResult;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  AssetListRecord? assetDocument;
  // Stores action output result for [Action Block - checkIsExpire] action in Container widget.
  bool? isExpire2;
  // Stores action output result for [Custom Action - exportExcel1] action in Container widget.
  String? path1;
  // Stores action output result for [Action Block - checkIsExpire] action in Container widget.
  bool? isExpire3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future checkCloseExpire(BuildContext context) async {
    if (functions.getStartDayTime(FFAppState().currentDate!) !=
        functions.getStartDayTime(getCurrentTimestamp)) {
      FFAppState().isSkipExpireAlert = false;
      FFAppState().currentDate = functions.getStartDayTime(getCurrentTimestamp);
      FFAppState().update(() {});
    }
    if (getCurrentTimestamp >
        functions.getBeforeDay(3, FFAppState().customerData.expireDate!)) {
      if (!FFAppState().isSkipExpireAlert) {
        if (functions.getStartDayTime(getCurrentTimestamp) <=
            functions.getStartDayTime(FFAppState().customerData.expireDate!)) {
          await showDialog(
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: WebViewAware(
                  child: ExpireAlertViewWidget(),
                ),
              );
            },
          );
        }
      }
    }
  }
}
