//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/theme/theme.dart';
import 'package:intl/intl.dart';

import 'msg_arrow_painter.dart';
import 'msg_box.dart';

class SendMsgBox extends StatelessWidget {
  final String message;
  final String firstLetter;
  final DateTime createDate;
 // final AnimationController animationController;
  const SendMsgBox(
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ColorConstants.principalColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: ThemeConfig.bodyText2.override(color: Colors.white),
              ),
            ),
          ),
          CustomPaint(
              painter: MsgArrowPainter(
            ColorConstants.principalColor,
          )),
          SizedBox(width: 10),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: ColorConstants.darkGray),
            child: Center(
              child: Text(
                firstLetter,
                style: ThemeConfig.bodyText1.override(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 0.0, left: 0, top: 15, bottom: 5),
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
