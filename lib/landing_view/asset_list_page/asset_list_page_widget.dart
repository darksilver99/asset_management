import '/asset_view/asset_form_view/asset_form_view_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'asset_list_page_model.dart';
export 'asset_list_page_model.dart';

class AssetListPageWidget extends StatefulWidget {
  const AssetListPageWidget({super.key});

  @override
  State<AssetListPageWidget> createState() => _AssetListPageWidgetState();
}

class _AssetListPageWidgetState extends State<AssetListPageWidget> {
  late AssetListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssetListPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
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
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: AssetFormViewWidget(),
                ),
              );
            },
          ).then((value) => safeSetState(() => _model.isUpdate = value));

          safeSetState(() {});
        },
        backgroundColor: FlutterFlowTheme.of(context).primary,
        icon: Icon(
          Icons.add_sharp,
          size: 18.0,
        ),
        elevation: 8.0,
        label: Text(
          'เพิ่มอุปกรณ์',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Kanit',
                color: FlutterFlowTheme.of(context).primaryBackground,
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        FlutterFlowChoiceChips(
                          options: [
                            ChipData('ใช้งานอยู่'),
                            ChipData('ว่าง'),
                            ChipData('ส่งซ่อม'),
                            ChipData('พังแล้ว'),
                            ChipData('ทั้งหมด')
                          ],
                          onChanged: (val) => safeSetState(
                              () => _model.choiceChipsValue = val?.firstOrNull),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Kanit',
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            iconColor: FlutterFlowTheme.of(context).info,
                            iconSize: 16.0,
                            labelPadding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 4.0, 8.0, 4.0),
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Kanit',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 16.0,
                            labelPadding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 4.0, 8.0, 4.0),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          chipSpacing: 8.0,
                          rowSpacing: 8.0,
                          multiselect: false,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                            [],
                          ),
                          wrapped: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PagedListView<DocumentSnapshot<Object?>?,
                  AssetListRecord>.separated(
                pagingController: _model.setListViewController(
                    AssetListRecord.collection(
                            FFAppState().customerData.customerRef)
                        .orderBy('purchase_date', descending: true),
                    parent: FFAppState().customerData.customerRef),
                padding: EdgeInsets.fromLTRB(
                  0,
                  8.0,
                  0,
                  180.0,
                ),
                reverse: false,
                scrollDirection: Axis.vertical,
                separatorBuilder: (_, __) => SizedBox(height: 8.0),
                builderDelegate: PagedChildBuilderDelegate<AssetListRecord>(
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

                  itemBuilder: (context, _, listViewIndex) {
                    final listViewAssetListRecord = _model
                        .listViewPagingController!.itemList![listViewIndex];
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
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
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          listViewAssetListRecord.subject,
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Kanit',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: functions.getColorStatus(
                                              listViewAssetListRecord.status),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 4.0, 12.0, 4.0),
                                          child: Text(
                                            listViewAssetListRecord.status,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Kanit',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'ใช้ที่แผนกไอที',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Kanit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
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
                                        'วันที่ซื้อ 22/22/2222',
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Kanit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
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
    );
  }
}