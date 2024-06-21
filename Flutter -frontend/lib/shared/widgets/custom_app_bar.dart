import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero/shared/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  final double barHeight = 113.0;

  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/horecah-logo-03.svg',
            width: 240,
          )
        ],
      )),
      color: ColorConstants.principalColor,
    );
  }
}
