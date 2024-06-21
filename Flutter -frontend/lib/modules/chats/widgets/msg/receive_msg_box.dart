import 'dart:math' as math;

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/theme/theme.dart';
import 'package:intl/intl.dart';

import 'msg_arrow_painter.dart';
import 'msg_box.dart';

class ReceiveMsgBox extends StatelessWidget {
  final String message;
  final String firstLetter;
  //final AnimationController animationController;
  final DateTime createDate;
  const ReceiveMsgBox(
      {Key? key,
      required this.message,
      required this.firstLetter,
      //required this.animationController,
      required this.createDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: ColorConstants.lightGray),
            child: Center(
              child: Text(
                firstLetter,
                style: ThemeConfig.bodyText1.override(
                  color: ColorConstants.titleSecundary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(painter: MsgArrowPainter(Colors.white)),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: ThemeConfig.bodyText2.override(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 0.0, left: 0, top: 10, bottom: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                DateFormat('dd/MM').format(createDate) +
                    ' - ' +
                    DateFormat('HH:mm').format(createDate),
                style: ThemeConfig.subtitle2.override(fontSize: 14),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 30),
              messageTextGroup,
            ],
          ),
        ],
      ),
    );
  }
}
