import '/asset_view/asset_form_view/asset_form_view_widget.dart';
import '/asset_view/asset_q_r_code_view/asset_q_r_code_view_widget.dart';
import '/asset_view/asset_status_view/asset_status_view_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/broken_view/broken_detail_view/broken_detail_view_widget.dart';
import '/broken_view/broken_form_view/broken_form_view_widget.dart';
import '/component/back_button_view/back_button_view_widget.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/location_view/location_form_view/location_form_view_widget.dart';
import '/lost_view/lost_form_view/lost_form_view_widget.dart';
import '/lost_view/lost_view/lost_view_widget.dart';
import '/repair_view/repair_form_view/repair_form_view_widget.dart';
import '/repair_view/repair_update_view/repair_update_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'asset_detail_page_widget.dart' show AssetDetailPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AssetDetailPageModel extends FlutterFlowModel<AssetDetailPageWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  AssetListRecord? assetDocument;

  ///  State fields for stateful widgets in this page.

  // Model for BackButtonView component.
  late BackButtonViewModel backButtonViewModel;
  // Stores action output result for [Action Block - confirmBlock] action in Button widget.
  bool? isConfirm;
  // Stores action output result for [Bottom Sheet - AssetFormView] action in Button widget.
  String? isUpdate;
  // Stores action output result for [Action Block - updateRepairData] action in Button widget.
  bool? isUpdateRepair;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  String? selectedStatus;
  // Stores action output result for [Bottom Sheet - LocationFormView] action in Button widget.
  String? locationDetail;
  // Stores action output result for [Bottom Sheet - LostFormView] action in Button widget.
  String? lostDetail;
  // Stores action output result for [Bottom Sheet - BrokenFormView] action in Button widget.
  String? brokenDetail;
  // Stores action output result for [Bottom Sheet - RepairFormView] action in Button widget.
  String? repairDetail;

  @override
  void initState(BuildContext context) {
    backButtonViewModel = createModel(context, () => BackButtonViewModel());
  }

  @override
  void dispose() {
    backButtonViewModel.dispose();
  }

  /// Action blocks.
  Future initAssetData(BuildContext context) async {
    AssetListRecord? assetResult;

    assetResult = await actions.getAssetData(
      widget!.assetDocument?.reference,
    );
    if (assetResult != null) {
      assetDocument = assetResult;
    } else {
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
              child: GestureDetector(
                onTap: () => FocusScope.of(dialogContext).unfocus(),
                child: InfoCustomViewWidget(
                  title: 'ไม่มีรายการนี้อยู่แล้ว',
                  status: 'info',
                ),
              ),
            ),
          );
        },
      );

      await actions.pushReplacement(
        context,
        null,
      );
    }
  }

  Future<bool?> updateRepairData(
    BuildContext context, {
    required DocumentReference? repairRef,
  }) async {
    RepairListRecord? repairDocumentResult;
    String? updateRepair;

    repairDocumentResult = await RepairListRecord.getDocumentOnce(repairRef!);
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return WebViewAware(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: RepairUpdateViewWidget(
                repairDocument: repairDocumentResult!,
              ),
            ),
          ),
        );
      },
    ).then((value) => updateRepair = value);

    if ((updateRepair != null && updateRepair != '') &&
        (updateRepair == 'update')) {
      return true;
    }

    return false;
  }
}
