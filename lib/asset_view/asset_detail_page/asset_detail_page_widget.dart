import '/asset_view/asset_form_view/asset_form_view_widget.dart';
import '/asset_view/asset_q_r_code_view/asset_q_r_code_view_widget.dart';
import '/asset_view/asset_status_view/asset_status_view_widget.dart';
import '/asset_view/location_form_view/location_form_view_widget.dart';
import '/asset_view/remark_form_view/remark_form_view_widget.dart';
import '/asset_view/remark_view/remark_view_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/component/back_button_view/back_button_view_widget.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'asset_detail_page_model.dart';
export 'asset_detail_page_model.dart';

class AssetDetailPageWidget extends StatefulWidget {
  const AssetDetailPageWidget({
    super.key,
    required this.assetDocument,
  });

  final AssetListRecord? assetDocument;

  @override
  State<AssetDetailPageWidget> createState() => _AssetDetailPageWidgetState();
}

class _AssetDetailPageWidgetState extends State<AssetDetailPageWidget> {
  late AssetDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssetDetailPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.initAssetData(context);
      _model.isLoading = false;
      safeSetState(() {});
    });
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.backButtonViewModel,
                updateCallback: () => safeSetState(() {}),
                child: BackButtonViewWidget(
                  title: 'รายละเอียด',
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              if (!_model.isLoading)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 4.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.isConfirm =
                                          await action_blocks.confirmBlock(
                                        context,
                                        title: 'ต้องการลบรายการนี้?',
                                        detail:
                                            'หากลบแล้วจะไม่สามารถเรียกคืนข้อมูลได้ รวมถึงข้อมูลสถานะต่างๆ ของรายการนี้',
                                      );
                                      if (_model.isConfirm!) {
                                        await _model.assetDocument!.reference
                                            .delete();
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () => FocusScope.of(
                                                          dialogContext)
                                                      .unfocus(),
                                                  child: InfoCustomViewWidget(
                                                    title:
                                                        'ลบข้อมูลเรียบร้อยแล้ว',
                                                    status: 'success',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        await actions.pushReplacement(
                                          context,
                                          'AssetListPage',
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'ลบ',
                                    icon: FaIcon(
                                      FontAwesomeIcons.trashAlt,
                                      size: 12.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 24.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      iconAlignment: IconAlignment.start,
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).error,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Kanit',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 1.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
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
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AssetFormViewWidget(
                                              assetDocument:
                                                  _model.assetDocument,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(
                                      () => _model.isUpdate = value));

                                  _model.isLoading = true;
                                  safeSetState(() {});
                                  if ((_model.isUpdate != null &&
                                          _model.isUpdate != '') &&
                                      (_model.isUpdate == 'update')) {
                                    await _model.initAssetData(context);
                                  }
                                  _model.isLoading = false;
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                                text: 'แก้ไข',
                                icon: FaIcon(
                                  FontAwesomeIcons.solidEdit,
                                  size: 12.0,
                                ),
                                options: FFButtonOptions(
                                  height: 24.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  iconAlignment: IconAlignment.start,
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).warning,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Kanit',
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 1.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: Container(
                            width: double.infinity,
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            _model.assetDocument!.image,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.jpg',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          allowRotation: false,
                                          tag: _model.assetDocument!.image,
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: _model.assetDocument!.image,
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.network(
                                        _model.assetDocument!.image,
                                        height: 200.0,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/error_image.jpg',
                                          height: 200.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
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
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AssetQRCodeViewWidget(
                                                assetDocument:
                                                    _model.assetDocument!,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 4.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.qrcode,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 32.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'QR Code',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'CheckListPage',
                                      queryParameters: {
                                        'assetDocument': serializeParam(
                                          _model.assetDocument,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'assetDocument': _model.assetDocument,
                                      },
                                    );
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 4.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .clipboardCheck,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 32.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ตรวจเช็ค\nอุปกรณ์',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                        if ((_model.assetDocument?.lastLocationRef != null) ||
                            (_model.assetDocument?.lastRepairRef != null))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_model.assetDocument?.lastLocationRef !=
                                    null)
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'LocationListPage',
                                          queryParameters: {
                                            'assetDocument': serializeParam(
                                              _model.assetDocument,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'assetDocument':
                                                _model.assetDocument,
                                          },
                                        );
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  4.0),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.cogs,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 32.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'รายการ\nใช้งาน',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Kanit',
                                                              fontSize: 18.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.0,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_model.assetDocument?.lastRepairRef != null)
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.tools,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 32.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'รายการ\nซ่อม',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Kanit',
                                                            fontSize: 18.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: Container(
                            width: double.infinity,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                4.0, 0.0),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'สถานะ : ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: _model
                                                                .assetDocument!
                                                                .status,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  color: functions
                                                                      .getColorStatus(_model
                                                                          .assetDocument!
                                                                          .status),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if ((_model.assetDocument?.status ==
                                                    'หาย') ||
                                                (_model.assetDocument?.status ==
                                                    'ใช้ไม่ได้แล้ว'))
                                              Builder(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if ((_model.assetDocument
                                                                ?.status ==
                                                            'ใช้ไม่ได้แล้ว') ||
                                                        (_model.assetDocument
                                                                ?.status ==
                                                            'หาย')) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child: WebViewAware(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () =>
                                                                    FocusScope.of(
                                                                            dialogContext)
                                                                        .unfocus(),
                                                                child:
                                                                    RemarkViewWidget(
                                                                  title:
                                                                      'รายละเอียด',
                                                                  date: () {
                                                                    if (_model
                                                                            .assetDocument
                                                                            ?.status ==
                                                                        'ใช้ไม่ได้แล้ว') {
                                                                      return _model
                                                                          .assetDocument!
                                                                          .brokenDate!;
                                                                    } else if (_model
                                                                            .assetDocument
                                                                            ?.status ==
                                                                        'หาย') {
                                                                      return _model
                                                                          .assetDocument!
                                                                          .lostDate!;
                                                                    } else {
                                                                      return getCurrentTimestamp;
                                                                    }
                                                                  }(),
                                                                  detail: () {
                                                                    if (_model
                                                                            .assetDocument
                                                                            ?.status ==
                                                                        'ใช้ไม่ได้แล้ว') {
                                                                      return _model
                                                                          .assetDocument
                                                                          ?.brokenDetail;
                                                                    } else if (_model
                                                                            .assetDocument
                                                                            ?.status ==
                                                                        'หาย') {
                                                                      return _model
                                                                          .assetDocument
                                                                          ?.lostDetail;
                                                                    } else {
                                                                      return '-';
                                                                    }
                                                                  }(),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.info_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 14.0,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          'รายละเอียดเพิ่มเติม',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Kanit',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            var _shouldSetState = false;
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus(),
                                                      child:
                                                          AssetStatusViewWidget(
                                                        currentStatus: _model
                                                            .assetDocument!
                                                            .status,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(() =>
                                                _model.selectedStatus = value));

                                            _shouldSetState = true;
                                            if (_model.selectedStatus != null &&
                                                _model.selectedStatus != '') {
                                              if (_model.selectedStatus ==
                                                  'ว่าง') {
                                                await _model
                                                    .assetDocument!.reference
                                                    .update({
                                                  ...createAssetListRecordData(
                                                    updateDate:
                                                        getCurrentTimestamp,
                                                    status: 'ว่าง',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'location':
                                                          FieldValue.delete(),
                                                    },
                                                  ),
                                                });
                                                await action_blocks
                                                    .insertTransaction(
                                                  context,
                                                  assetReference: _model
                                                      .assetDocument?.reference,
                                                  refPath: '',
                                                  subject: _model
                                                      .assetDocument?.subject,
                                                  remark:
                                                      'ปรับสถานะเป็น \"ว่าง\"',
                                                );
                                              } else if (_model
                                                      .selectedStatus ==
                                                  'ใช้งาน') {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              LocationFormViewWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => safeSetState(
                                                    () => _model
                                                            .locationDataList =
                                                        value));

                                                _shouldSetState = true;
                                                if (_model.locationDataList !=
                                                        null &&
                                                    (_model.locationDataList)!
                                                        .isNotEmpty) {
                                                  var locationListRecordReference =
                                                      LocationListRecord
                                                          .createDoc(FFAppState()
                                                              .customerData
                                                              .customerRef!);
                                                  await locationListRecordReference
                                                      .set(
                                                          createLocationListRecordData(
                                                    createDate:
                                                        getCurrentTimestamp,
                                                    remark: _model
                                                        .locationDataList?.last,
                                                    assetRef: _model
                                                        .assetDocument
                                                        ?.reference,
                                                    locationName: _model
                                                        .locationDataList
                                                        ?.first,
                                                  ));
                                                  _model.locationInserted =
                                                      LocationListRecord
                                                          .getDocumentFromData(
                                                              createLocationListRecordData(
                                                                createDate:
                                                                    getCurrentTimestamp,
                                                                remark: _model
                                                                    .locationDataList
                                                                    ?.last,
                                                                assetRef: _model
                                                                    .assetDocument
                                                                    ?.reference,
                                                                locationName: _model
                                                                    .locationDataList
                                                                    ?.first,
                                                              ),
                                                              locationListRecordReference);
                                                  _shouldSetState = true;

                                                  await _model
                                                      .assetDocument!.reference
                                                      .update(
                                                          createAssetListRecordData(
                                                    updateDate:
                                                        getCurrentTimestamp,
                                                    status: 'ใช้งานอยู่',
                                                    lastLocationRef: _model
                                                        .locationInserted
                                                        ?.reference,
                                                    location: _model
                                                        .locationDataList
                                                        ?.first,
                                                  ));
                                                  await action_blocks
                                                      .insertTransaction(
                                                    context,
                                                    assetReference: _model
                                                        .assetDocument
                                                        ?.reference,
                                                    refPath: functions
                                                        .getLocationPath(_model
                                                            .locationInserted!
                                                            .reference),
                                                    subject:
                                                        '${_model.assetDocument?.subject} ถูกใช้งาน',
                                                    remark: _model
                                                        .locationDataList
                                                        ?.first,
                                                  );
                                                } else {
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                              } else if (_model
                                                      .selectedStatus ==
                                                  'หาย') {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              RemarkFormViewWidget(
                                                            hintText:
                                                                'ระบุรายละเอียดเพิ่มเติม เช่น หายที่ไหน, ใครเป็นคนแจ้ง',
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => safeSetState(
                                                    () => _model.lostDetail =
                                                        value));

                                                _shouldSetState = true;
                                                if (_model.lostDetail != null &&
                                                    _model.lostDetail != '') {
                                                  await _model
                                                      .assetDocument!.reference
                                                      .update({
                                                    ...createAssetListRecordData(
                                                      updateDate:
                                                          getCurrentTimestamp,
                                                      status: 'หาย',
                                                      lostDetail:
                                                          _model.lostDetail,
                                                      lostDate:
                                                          getCurrentTimestamp,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'location':
                                                            FieldValue.delete(),
                                                      },
                                                    ),
                                                  });
                                                  await action_blocks
                                                      .insertTransaction(
                                                    context,
                                                    assetReference: _model
                                                        .assetDocument
                                                        ?.reference,
                                                    refPath: '',
                                                    subject: _model
                                                        .assetDocument?.subject,
                                                    remark:
                                                        'ปรับสถานะเป็น \"หาย\"',
                                                  );
                                                } else {
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                              } else if (_model
                                                      .selectedStatus ==
                                                  'ใช้ไม่ได้แล้ว') {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              RemarkFormViewWidget(
                                                            hintText:
                                                                'ระบุรายละเอียดเพิ่มเติม เช่น สาเหตุที่ใช้ไม่ได้',
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => safeSetState(
                                                    () => _model.brokenDetail =
                                                        value));

                                                _shouldSetState = true;
                                                if (_model.brokenDetail !=
                                                        null &&
                                                    _model.brokenDetail != '') {
                                                  await _model
                                                      .assetDocument!.reference
                                                      .update({
                                                    ...createAssetListRecordData(
                                                      updateDate:
                                                          getCurrentTimestamp,
                                                      status: 'ใช้ไม่ได้แล้ว',
                                                      brokenDate:
                                                          getCurrentTimestamp,
                                                      brokenDetail:
                                                          _model.brokenDetail,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'location':
                                                            FieldValue.delete(),
                                                      },
                                                    ),
                                                  });
                                                  await action_blocks
                                                      .insertTransaction(
                                                    context,
                                                    assetReference: _model
                                                        .assetDocument
                                                        ?.reference,
                                                    refPath: '',
                                                    subject: _model
                                                        .assetDocument?.subject,
                                                    remark:
                                                        'ปรับสถานะเป็น \"ใช้ไม่ได้แล้ว\"',
                                                  );
                                                } else {
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                              } else if (_model
                                                      .selectedStatus ==
                                                  'ส่งซ่อม') {
                                                await _model
                                                    .assetDocument!.reference
                                                    .update({
                                                  ...createAssetListRecordData(
                                                    updateDate:
                                                        getCurrentTimestamp,
                                                    status: 'ส่งซ่อม',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'location':
                                                          FieldValue.delete(),
                                                    },
                                                  ),
                                                });
                                                await action_blocks
                                                    .insertTransaction(
                                                  context,
                                                  assetReference: _model
                                                      .assetDocument?.reference,
                                                  refPath: '',
                                                  subject: _model
                                                      .assetDocument?.subject,
                                                  remark: 'ทำการส่งซ่อม',
                                                );
                                              } else {
                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }

                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus(),
                                                        child:
                                                            InfoCustomViewWidget(
                                                          title:
                                                              'บันทึกข้อมูลเรียบร้อยแล้ว',
                                                          status: 'success',
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              await actions.pushReplacement(
                                                context,
                                                'AssetListPage',
                                              );
                                            }
                                            if (_shouldSetState)
                                              safeSetState(() {});
                                          },
                                          text: 'เปลี่ยนสถานะ',
                                          icon: Icon(
                                            Icons
                                                .published_with_changes_rounded,
                                            size: 18.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 42.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Kanit',
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: Container(
                            width: double.infinity,
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
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'วันที่ซื้ออุปกรณ์ ${functions.dateTh(_model.assetDocument?.purchaseDate)}',
                                          textAlign: TextAlign.end,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Kanit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 14.0,
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
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: _model
                                                    .assetDocument!.subject,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' (${_model.assetDocument?.serialNumber})',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Kanit',
                                                  letterSpacing: 0.0,
                                                ),
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
                                          'ราคา ${formatNumber(
                                            _model.assetDocument?.price,
                                            formatType: FormatType.decimal,
                                            decimalType: DecimalType.automatic,
                                          )}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Kanit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_model.assetDocument?.detail != null &&
                                      _model.assetDocument?.detail != '')
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            valueOrDefault<String>(
                                              _model.assetDocument?.detail,
                                              '-',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Kanit',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 18.0,
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
                        ),
                      ]
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 80.0)),
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
