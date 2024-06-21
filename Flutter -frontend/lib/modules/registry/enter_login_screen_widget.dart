import 'package:get/get.dart';
import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterLoginScreenWidget extends StatefulWidget {
  EnterLoginScreenWidget();

  @override
  _EnterLoginScreenWidgetState createState() => _EnterLoginScreenWidgetState();
}

class _EnterLoginScreenWidgetState extends State<EnterLoginScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                child: Image.asset(
                  'assets/images/icon_create_ad.PNG',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),*/
              Text(
                'join_horecah1'.tr,
                textAlign: TextAlign.center,
                style: ThemeConfig.bodyText1.override(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'join_horecah2'.tr,
                textAlign: TextAlign.center,
                style: ThemeConfig.bodyText1.override(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () async {
                  Get.toNamed(Routes.LOGIN);
                },
                child: ButtonContinueWidget(
                  labelButton: "login_label".tr,
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.LOGIN + Routes.REGISTER);
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    height: 60,
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: ColorConstants.principalColor)),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'register_label'.tr,
                        textAlign: TextAlign.center,
                        style: ThemeConfig.bodyText1.override(
                          color: ColorConstants.principalColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                /*Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: ColorConstants.principalColor,
                                width: .5,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'register_label'.tr,
                                textAlign: TextAlign.center,
                                style: ThemeConfig.bodyText1.override(
                                  color: ColorConstants.principalColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),*/
              ),

              /*InkWell(
                onTap: () async {
                   Get.toNamed(Routes.LOGIN + Routes.REGISTER);
                },
                child: ButtonContinueWidget( labelButton: "Registrati", ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
