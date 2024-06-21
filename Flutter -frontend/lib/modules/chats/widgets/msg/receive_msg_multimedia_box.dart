import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:intl/intl.dart';

import 'msg_arrow_painter.dart';
import 'msg_box.dart';

class ReceiveMsgMultimediaBox extends StatelessWidget {
  final String urlImage;
  final String firstLetter;
  //final AnimationController animationController;
  final String type;
  final DateTime createDate;
  const ReceiveMsgMultimediaBox({
    Key? key,
    required this.urlImage,
    required this.firstLetter,
    //required this.animationController,
    required this.createDate,
    this.type = 'image',
  }) : super(key: key);

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
              child: InkWell(
                child: Card(
                    color: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: .8,
                      ),
                    ),
                    child: Container(
                        height: 60,
                        width: 80,
                        child: type == 'image'
                            ? CachedNetworkImage(
                                imageUrl: urlImage, fit: BoxFit.cover)
                            : Icon(
                                Icons.picture_as_pdf_rounded,
                                color: Colors.black87,
                                size: 35,
                              ))),
                onTap: () => type == 'image'
                    ? CommonWidget.showModalImage(urlImage)
                    : CommonWidget.previewFilew(urlImage),
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
