import '/app_suggest_view/app_suggest_view/app_suggest_view_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/component/loading_view/loading_view_widget.dart';
import '/component/main_background_view/main_background_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/other_view/issue_view/issue_view_widget.dart';
import '/other_view/suggest_view/suggest_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'more_page_widget.dart' show MorePageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MorePageModel extends FlutterFlowModel<MorePageWidget> {
  ///  Local state fields for this page.

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  // Model for MainBackgroundView component.
  late MainBackgroundViewModel mainBackgroundViewModel;
  // Stores action output result for [Action Block - confirmBlock] action in Text widget.
  bool? isConfirm2;
  // Stores action output result for [Action Block - checkIsExpire] action in Column widget.
  bool? isExpire2;
  // Stores action output result for [Custom Action - exportExcel1] action in Column widget.
  String? path1;
  // Stores action output result for [Action Block - checkIsExpire] action in Column widget.
  bool? isExpire3;
  // Stores action output result for [Custom Action - exportExcel2] action in Column widget.
  String? path2;
  // Stores action output result for [Action Block - confirmBlock] action in Column widget.
  bool? isConfirm;
  // Model for LoadingView component.
  late LoadingViewModel loadingViewModel;

  @override
  void initState(BuildContext context) {
    mainBackgroundViewModel =
        createModel(context, () => MainBackgroundViewModel());
    loadingViewModel = createModel(context, () => LoadingViewModel());
  }

  @override
  void dispose() {
    mainBackgroundViewModel.dispose();
    loadingViewModel.dispose();
  }
}
