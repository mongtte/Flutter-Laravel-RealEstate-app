import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/shared/shared.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: ColorConstants.principalColor,
      child: Center(
        child: Center(
            child: SvgPicture.asset(
          'assets/svgs/horecah-logo-03.svg',
          width: SizeConfig().screenWidth,
        )),
      ),
    );
  }
}
