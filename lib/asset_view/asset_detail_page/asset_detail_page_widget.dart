import '/asset_view/asset_form_view/asset_form_view_widget.dart';
import '/backend/backend.dart';
import '/component/back_button_view/back_button_view_widget.dart';
import '/component/info_custom_view/info_custom_view_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
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

                                        context.safePop();
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
                                      elevation: 0.0,
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
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
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
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'สถานะ : ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              TextSpan(
                                                text: _model
                                                    .assetDocument!.status,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Kanit',
                                                          color: functions
                                                              .getColorStatus(_model
                                                                  .assetDocument!
                                                                  .status),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 16.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'รายการตรวจเช็คอุปกรณ์',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 52.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).tertiary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Kanit',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
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
                                        child: Text(
                                          valueOrDefault<String>(
                                            _model.assetDocument?.subject,
                                            '-',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Kanit',
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
