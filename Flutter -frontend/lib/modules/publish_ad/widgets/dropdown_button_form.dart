// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:hero/theme/theme.dart';

//====================SUBCATEGORIAS==================================

class DropDownButtonForm extends StatefulWidget {
  List<String> listOptions;
  String actualValue;
  EnumTypeList type;
  Function(String)? callback;

  DropDownButtonForm(
      {required this.actualValue,
      required this.listOptions,
      required this.type,
      this.callback});

  @override
  _DropDownButtonFormState createState() => _DropDownButtonFormState();
}

class _DropDownButtonFormState extends State<DropDownButtonForm> {
  var controller = Get.find<PublishAdController>();

  @override
  void initState() {
    controller.currentSubCatStr = widget.actualValue;
    controller.defaultList = widget.listOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.actualValue;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      isExpanded: true,
      isDense: true,
      iconSize: 22,
      elevation: 16,
      style: ThemeConfig.bodyText1.override(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: ColorConstants.lightGray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: ColorConstants.principalColor, width: 1.5),
        ),
        labelStyle: ThemeConfig.subtitle1.override(
          color: Colors.black,
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (newValue != dropdownValue) {
            dropdownValue = newValue!;
          }
        });

        if (widget.callback != null)
          widget.callback!(newValue!);
        else {
          controller.itemUpdate(widget.type, newValue!);
          controller.currentSubCatStr = newValue;
        }
      },
      items: widget.listOptions.map<DropdownMenuItem<String>>((String value) {
        print("===========SUBCATEGORY========= $value");
        return DropdownMenuItem<String>(
            value: value,
            child: Text(
              "$value".tr,
              textScaleFactor: 1,
            ));
      }).toList(),
    );
  }
}

//====================PEOPLETYPE==================================

class DropDownButtonFormPeopleType extends StatefulWidget {
  List<String> listOptions;
  String actualValue;
  EnumTypeList type;
  DropDownButtonFormPeopleType(
      {required this.actualValue,
      required this.listOptions,
      required this.type});

  @override
  _DropDownButtonFormPeopleTypeState createState() =>
      _DropDownButtonFormPeopleTypeState();
}

class _DropDownButtonFormPeopleTypeState
    extends State<DropDownButtonFormPeopleType> {
  var controller = Get.find<PublishAdController>();

  @override
  void initState() {
    super.initState();
    controller.currenPeopleTypeStr = widget.actualValue;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.actualValue;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      isExpanded: true,
      isDense: true,
      iconSize: 22,
      elevation: 16,
      style: ThemeConfig.bodyText1.override(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: ColorConstants.lightGray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: ColorConstants.principalColor, width: 1.5),
        ),
        labelStyle: ThemeConfig.subtitle1.override(
          color: Colors.black,
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (newValue != dropdownValue) {
            dropdownValue = newValue!;
          }
        });
        controller.itemUpdate(widget.type, newValue!);
        controller.currenPeopleTypeStr = newValue;
      },
      items: widget.listOptions.map<DropdownMenuItem<String>>((String value) {
        print("value People Type====== $value");
        return DropdownMenuItem<String>(
            value: value,
            child: Text(
              "$value".tr,
              textScaleFactor: 1,
            ));
      }).toList(),
    );
  }
}

//====================ADTYPE==================================

class DropDownButtonFormAdType extends StatefulWidget {
  List<String> listOptions;
  String actualValue;
  EnumTypeList type;
  DropDownButtonFormAdType(
      {required this.actualValue,
      required this.listOptions,
      required this.type});

  @override
  _DropDownButtonFormAdTypeState createState() =>
      _DropDownButtonFormAdTypeState();
}

class _DropDownButtonFormAdTypeState extends State<DropDownButtonFormAdType> {
  var controller = Get.find<PublishAdController>();

  @override
  void initState() {
    controller.currentAdTypeStr = widget.actualValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build dropdown adtype!!!!!!!==============");

    String dropdownValue = widget.actualValue;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      isExpanded: true,
      isDense: true,
      iconSize: 22,
      elevation: 16,
      style: ThemeConfig.bodyText1.override(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: ColorConstants.lightGray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: ColorConstants.principalColor, width: 1.5),
        ),
        labelStyle: ThemeConfig.subtitle1.override(
          color: Colors.black,
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (newValue != dropdownValue) {
            dropdownValue = newValue!;
          }
        });
        controller.itemUpdate(widget.type, newValue!);
        controller.currentAdTypeStr = newValue;
      },
      items: widget.listOptions.map<DropdownMenuItem<String>>((String value) {
        print("======VALUE==========$value");
        return DropdownMenuItem<String>(
            value: value,
            child: Text(
              "$value".tr,
              textScaleFactor: 1,
            ));
      }).toList(),
    );
  }
}

class DropDownButtonFormCondizione extends StatefulWidget {
  List<String> listOptions;
  String actualValue;
  EnumTypeList type;
  DropDownButtonFormCondizione(
      {required this.actualValue,
      required this.listOptions,
      required this.type});

  @override
  _DropDownButtonFormCondizioneState createState() =>
      _DropDownButtonFormCondizioneState();
}

class _DropDownButtonFormCondizioneState
    extends State<DropDownButtonFormCondizione> {
  var controller = Get.find<PublishAdController>();

  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.actualValue;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      isExpanded: true,
      isDense: true,
      iconSize: 22,
      elevation: 16,
      style: ThemeConfig.bodyText1.override(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: ColorConstants.lightGray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: ColorConstants.principalColor, width: 1.5),
        ),
        labelStyle: ThemeConfig.subtitle1.override(
          color: Colors.black,
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (newValue != dropdownValue) {
            dropdownValue = newValue!;
          }
        });
        controller.itemUpdate(widget.type, newValue!);
        controller.currentCondizioneStr = newValue;
      },
      items: widget.listOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value.tr,
              textScaleFactor: 1,
            ));
      }).toList(),
    );
  }
}
