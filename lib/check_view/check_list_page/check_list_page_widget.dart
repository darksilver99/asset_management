import '/backend/backend.dart';
import '/check_view/check_detail_view/check_detail_view_widget.dart';
import '/check_view/check_form_view/check_form_view_widget.dart';
import '/component/back_button_view/back_button_view_widget.dart';
import '/component/no_data_view/no_data_view_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'check_list_page_model.dart';
export 'check_list_page_model.dart';

class CheckListPageWidget extends StatefulWidget {
  const CheckListPageWidget({
    super.key,
    required this.assetDocument,
  });

  final AssetListRecord? assetDocument;

  @override
  State<CheckListPageWidget> createState() => _CheckListPageWidgetState();
}

class _CheckListPageWidgetState extends State<CheckListPageWidget> {
  late CheckListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckListPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
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
                      child: CheckFormViewWidget(
                        assetReference: widget!.assetDocument!.reference,
                      ),
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() => _model.isUpdate = value));

            if ((_model.isUpdate != null && _model.isUpdate != '') &&
                (_model.isUpdate == 'update')) {
              if (Navigator.of(context).canPop()) {
                context.pop();
              }
              context.pushNamed(
                'CheckListPage',
                queryParameters: {
                  'assetDocument': serializeParam(
                    widget!.assetDocument,
                    ParamType.Document,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  'assetDocument': widget!.assetDocument,
                },
              );
            }

            safeSetState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: FaIcon(
            FontAwesomeIcons.clipboardCheck,
          ),
          elevation: 8.0,
          label: Text(
            'บันทึกการตรวจ',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Kanit',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.backButtonViewModel,
                updateCallback: () => safeSetState(() {}),
                child: BackButtonViewWidget(
                  title: 'รายการตรวจเช็คอุปกรณ์',
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              Expanded(
                child: PagedListView<DocumentSnapshot<Object?>?,
                    CheckListRecord>.separated(
                  pagingController: _model.setListViewController(
                      CheckListRecord.collection(
                              FFAppState().customerData.customerRef)
                          .where(
                            'asset_ref',
                            isEqualTo: widget!.assetDocument?.reference,
                          )
                          .orderBy('create_date', descending: true),
                      parent: FFAppState().customerData.customerRef),
                  padding: EdgeInsets.fromLTRB(
                    0,
                    8.0,
                    0,
                    80.0,
                  ),
                  reverse: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (_, __) => SizedBox(height: 8.0),
                  builderDelegate: PagedChildBuilderDelegate<CheckListRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                    // Customize what your widget looks like when it's loading another page.
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => NoDataViewWidget(),
                    itemBuilder: (context, _, listViewIndex) {
                      final listViewCheckListRecord = _model
                          .listViewPagingController!.itemList![listViewIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return WebViewAware(
                                  child: GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: CheckDetailViewWidget(
                                        checkDocument: listViewCheckListRecord,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'ตรวจเช็คเมื่อ ${functions.dateTimeTh(listViewCheckListRecord.createDate)}',
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 18.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'โดย ${listViewCheckListRecord.checkerName}',
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Kanit',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
