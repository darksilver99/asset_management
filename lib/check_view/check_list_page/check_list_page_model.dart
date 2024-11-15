import '/backend/backend.dart';
import '/component/back_button_view/back_button_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'check_list_page_widget.dart' show CheckListPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckListPageModel extends FlutterFlowModel<CheckListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BackButtonView component.
  late BackButtonViewModel backButtonViewModel;

  @override
  void initState(BuildContext context) {
    backButtonViewModel = createModel(context, () => BackButtonViewModel());
  }

  @override
  void dispose() {
    backButtonViewModel.dispose();
  }
}
