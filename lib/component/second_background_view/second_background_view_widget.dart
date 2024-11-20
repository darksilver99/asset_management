import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'second_background_view_model.dart';
export 'second_background_view_model.dart';

class SecondBackgroundViewWidget extends StatefulWidget {
  const SecondBackgroundViewWidget({super.key});

  @override
  State<SecondBackgroundViewWidget> createState() =>
      _SecondBackgroundViewWidgetState();
}

class _SecondBackgroundViewWidgetState
    extends State<SecondBackgroundViewWidget> {
  late SecondBackgroundViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondBackgroundViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: SvgPicture.asset(
              'assets/images/19962856_6198974.svg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0x8E000000),
            ),
          ),
        ],
      ),
    );
  }
}
