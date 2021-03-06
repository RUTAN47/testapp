import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class RateCourtPageWidget extends StatefulWidget {
  RateCourtPageWidget({
    Key key,
    this.court,
  }) : super(key: key);

  final CourtsRecord court;

  @override
  _RateCourtPageWidgetState createState() => _RateCourtPageWidgetState();
}

class _RateCourtPageWidgetState extends State<RateCourtPageWidget> {
  TextEditingController textController;
  double ratingBarValue;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.darkBG,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Rate Court',
          style: FlutterFlowTheme.title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Comment',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Overpass',
                            color: FlutterFlowTheme.iconGray,
                            fontSize: 15,
                          ),
                          hintText: 'Saturdays at noon',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Overpass',
                            color: FlutterFlowTheme.iconGray,
                            fontSize: 15,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Overpass',
                          color: FlutterFlowTheme.iconGray,
                          fontSize: 15,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
                      child: RatingBar.builder(
                        onRatingUpdate: (newValue) =>
                            setState(() => ratingBarValue = newValue),
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.primaryColor,
                        ),
                        direction: Axis.horizontal,
                        initialRating: ratingBarValue ??= 3,
                        unratedColor: FlutterFlowTheme.grayLines,
                        itemCount: 5,
                        itemSize: 40,
                        glowColor: FlutterFlowTheme.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() => _loadingButton = true);
                          try {
                            final commentsCreateData = createCommentsRecordData(
                              user: currentUserReference,
                              text: textController.text,
                              court: widget.court.reference,
                              courtQualityRating: ratingBarValue,
                            );
                            await CommentsRecord.collection
                                .doc()
                                .set(commentsCreateData);
                            Navigator.pop(context);
                          } finally {
                            setState(() => _loadingButton = false);
                          }
                        },
                        text: 'Add Review',
                        options: FFButtonOptions(
                          width: 290,
                          height: 50,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.title3.override(
                            fontFamily: 'Overpass',
                            color: FlutterFlowTheme.white,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                        loading: _loadingButton,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
