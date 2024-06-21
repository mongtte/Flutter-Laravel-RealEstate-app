// ignore_for_file: prefer_final_fields, unused_field

import 'dart:io';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:hero/shared/shared.dart';
//import 'package:hero/shared/widgets/custom_widgets.dart';
import 'package:hero/theme/theme.dart';
import 'package:image_picker/image_picker.dart';

class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  final ImagePicker _picker = ImagePicker();
  var controller = Get.find<PublishAdController>();
  String? _pickImageError = '';

  String local = TranslationService.locale.toString();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: .6,
            initialPage: 0,
            enableInfiniteScroll: false,
            autoPlay: false,
            reverse: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: controller.imagesToUpload.map((image) {
            int index = controller.imagesToUpload.indexOf(image);
            return InkWell(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1,
                      color: ColorConstants.darkGray,
                    ),
                    color: Colors.white),
                child: image.path == ''
                    ? Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: ColorConstants.darkGray,
                          size: 45,
                        ),
                      )
                    : Stack(children: [
                        Container(
                            width: 200,
                            height: 200,
                            child: Image.file(
                              File(image.path),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )),
                        InkWell(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              color: Colors.red.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Text(
                                  local.substring(0, 3) == "it_"
                                      ? "Rimuovere"
                                      : local.substring(0, 3) == "en_"
                                          ? "Remove"
                                          : "Remover",
                                  style: ThemeConfig.bodyText1
                                      .override(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.imagesToUpload[index] = XFile('');
                            controller.imageCount--;
                          },
                        )
                      ]),
              ),
              onTap: () => _showPicker(index),
            );
          }).toList()),
    );
  }

  void _showPicker(int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: CommonWidget.getScreenSizeFontFixed(
              Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: local.substring(0, 3) == "it_"
                            ? Text("Galleria")
                            : local.substring(0, 3) == "en_"
                                ? Text("Gallery")
                                : Text("Galería"),
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery, index);
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: local.substring(0, 3) == "it_"
                          ? Text("Telecamera")
                          : local.substring(0, 3) == "en_"
                              ? Text("Camera")
                              : Text("Cámara"),
                      onTap: () {
                        _onImageButtonPressed(ImageSource.camera, index);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onImageButtonPressed(ImageSource source, int index,
      {bool isMultiImage = false}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 50,
      );
      controller.imagesToUpload[index] = (pickedFile!);
      controller.imageCount = controller.imageCount + 1;
    } catch (e) {}
  }
}
