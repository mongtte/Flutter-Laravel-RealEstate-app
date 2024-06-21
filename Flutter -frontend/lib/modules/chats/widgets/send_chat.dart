// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hero/models/chats/chats.dart';
import 'package:hero/models/chats/rooms_chats.dart';
import 'package:hero/modules/chats/widgets/msg/msg_box.dart';
import 'package:hero/modules/chats/widgets/msg/receive_msg_box.dart';
import 'package:hero/modules/chats/widgets/msg/receive_msg_multimedia_box.dart';
import 'package:hero/modules/chats/widgets/msg/send_msg_box.dart';
import 'package:hero/modules/chats/widgets/msg/send_msg_multimedia_box.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
//import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SendChat extends StatefulWidget {
  RoomsChats roomChat;
  SendChat({required this.roomChat});

  @override
  _SendChatState createState() => _SendChatState();
}

class _SendChatState extends State<SendChat> with TickerProviderStateMixin {
  final List<MsgBox> _messages = [];
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  var controllerPublishAd = Get.find<PublishAdController>();
  final _textController = TextEditingController();
  var controller = Get.find<HomeController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionRoom;
  late RoomsChats roomChat;
  late var channel;
  bool _isComposing = false;
  bool _isSelf = true;

  @override
  void initState() {
    super.initState();
    if (widget.roomChat.id != null) {
      roomChat = widget.roomChat;
      collectionRoom = firestore.collection("ChatRoom${roomChat.id}");

      print("roomChat${roomChat.id}");
    }
    // if (roomChat.chats != null && roomChat.chats!.length > 0) {
    //   //roomChat.chats!.sort((a, b) => a.id!.compareTo(b.id!));
    //   for (var chat in roomChat.chats!) {
    //     if (chat.user.id == controller.userStrapi.value!.id) {
    //       if (chat.type == 'text') {
    //         _messages.insert(
    //             0,
    //             SendMsgBox(
    //               message: chat.message,
    //               firstLetter:
    //                   chat.user.nameLastname.toString()[0].toUpperCase(),
    //               animationController: _buildAnimationController(),
    //               createDate: chat.createdAt!,
    //             ));
    //       } else if (chat.type == 'image') {
    //         _messages.insert(
    //             0,
    //             SendMsgMultimediaBox(
    //                 urlImage: chat.multimedia!.url,
    //                 firstLetter:
    //                     chat.user.nameLastname.toString()[0].toUpperCase(),
    //                 animationController: _buildAnimationController(),
    //                 createDate: chat.createdAt!));
    //       } else if (chat.type == 'file') {
    //         _messages.insert(
    //             0,
    //             SendMsgMultimediaBox(
    //                 urlImage: chat.multimedia!.url,
    //                 firstLetter:
    //                     chat.user.nameLastname.toString()[0].toUpperCase(),
    //                 animationController: _buildAnimationController(),
    //                 createDate: chat.createdAt!,
    //                 type: 'file'));
    //       }
    //     } else {
    //       if (chat.type == 'text') {
    //         _messages.insert(
    //             0,
    //             ReceiveMsgBox(
    //               message: chat.message,
    //               firstLetter:
    //                   chat.user.nameLastname.toString()[0].toUpperCase(),
    //               animationController: _buildAnimationController(),
    //               createDate: chat.createdAt!,
    //             ));
    //       } else if (chat.type == 'image') {
    //         _messages.insert(
    //             0,
    //             ReceiveMsgMultimediaBox(
    //                 urlImage: chat.multimedia!.url,
    //                 firstLetter:
    //                     chat.user.nameLastname.toString()[0].toUpperCase(),
    //                 animationController: _buildAnimationController(),
    //                 createDate: chat.createdAt!));
    //       } else if (chat.type == 'file') {
    //         _messages.insert(
    //             0,
    //             ReceiveMsgMultimediaBox(
    //                 urlImage: chat.multimedia!.url,
    //                 firstLetter:
    //                     chat.user.nameLastname.toString()[0].toUpperCase(),
    //                 animationController: _buildAnimationController(),
    //                 createDate: chat.createdAt!,
    //                 type: 'file'));
    //       }
    //     }
    //   }
    // }
    Future.delayed(Duration(milliseconds: 250), () {
      _focusNode.requestFocus();
      _messages.forEach((message) {
        message.animationController.forward();
      });
    });
    // var websocketUrl = 'ws://6.tcp.eu.ngrok.io:10963/ws';
    // channel = WebSocketChannel.connect(
    //   Uri.parse(websocketUrl),
    // );
  }

  @override
  Widget build(BuildContext context) {
    int chat_count = 0;
    // channel.stream.listen((message) {
    //   setState(() {
    //     print(message);
    //     // if (jsonDecode(message)["msg_id"] != "") {
    //     //   channel.sink.add(jsonEncode({
    //     //     "msg_type": "MESSAGE_READ",
    //     //     "msg_id": jsonDecode(message)["msg_id"],
    //     //     "user": GlobalVariables.username
    //     //   }));
    //     // }
    //   });
    // });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.roomChat.post!.nameLastname!.capitalize!,
                  style:
                      ThemeConfig.title3.override(fontWeight: FontWeight.w600),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  widget.roomChat.post!.email ?? 'no email',
                  style: ThemeConfig.subtitle2.override(fontSize: 12),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          //brightness: Brightness.dark,
          leading: IconButton(
              icon: Icon(Icons.close, size: 24, color: ColorConstants.darkGray),
              onPressed: () {
                controller.getRooms(2);
                Get.back();
              }),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(
              child: Container(
                color: Colors.white,
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: widget.roomChat.product != null
                              ? CachedNetworkImage(
                                  imageUrl: widget
                                      .roomChat.product!.multimedia!.first.url,
                                  fit: BoxFit.cover)
                              : Container(
                                  child: Icon(
                                    Icons.thumb_down_off_alt_rounded,
                                    color: ColorConstants.darkGray,
                                    size: 30,
                                  ),
                                )),
                    ),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                widget.roomChat.product != null
                                    ? widget.roomChat.product!.title.length > 16
                                        ? '${widget.roomChat.product!.title.substring(0, 16)}...'
                                        : widget
                                            .roomChat.product!.title.capitalize!
                                    : 'Annuncio no disponible',
                                style: ThemeConfig.subtitle2
                                    .override(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  widget.roomChat.product != null
                                      ? widget.roomChat.product!.price
                                              .toString() +
                                          ' ' +
                                          'coin'.tr
                                      : '',
                                  style: ThemeConfig.subtitle2.override(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              // onTap: () {
              //   controllerPublishAd.setActualProduct(widget.roomChat.product!);
              //   Get.toNamed(Routes.HOME + Routes.SHOW_AD);
              // },
            ),
            widget.roomChat.id != null
                ? Flexible(
                    // child: ListView.builder(
                    //   padding: const EdgeInsets.only(
                    //       left: 8, right: 8, bottom: 8, top: 60),
                    //   reverse: true,
                    //   itemBuilder: (_, index) => _messages[index],
                    //   itemCount: _messages.length,
                    // ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: collectionRoom.orderBy('date').snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Center();
                          default:
                            var documents =
                                snapshot.data?.docs.reversed.toList() ??
                                    <QueryDocumentSnapshot>[];
                            return ListView.builder(
                                itemCount: documents.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  if (documents[index]['user'] ==
                                      controller.userStrapi.value!.id) {
                                    if (documents[index]['url'] == '') {
                                      return SendMsgBox(
                                          message: documents[index]['message'],
                                          firstLetter: documents[index]
                                              ['firstLetter'],
                                          //animationController: _buildAnimationController(),
                                          createDate: (documents[index]['date'])
                                              .toDate());
                                    } else {
                                      if (documents[index]['type'] == "image") {
                                        return SendMsgMultimediaBox(
                                            type: "image",
                                            urlImage: documents[index]['url'],
                                            firstLetter: documents[index]
                                                ['firstLetter'],
                                            //animationController: _buildAnimationController(),
                                            createDate: (documents[index]
                                                    ['date'])
                                                .toDate());
                                      } else {
                                        return SendMsgMultimediaBox(
                                            type: "file",
                                            urlImage: documents[index]['url'],
                                            firstLetter: documents[index]
                                                ['firstLetter'],
                                            //animationController: _buildAnimationController(),
                                            createDate: (documents[index]
                                                    ['date'])
                                                .toDate());
                                      }
                                    }
                                  } else {
                                    if (documents[index]['url'] == '') {
                                      return ReceiveMsgBox(
                                          message: documents[index]['message'],
                                          firstLetter: documents[index]
                                              ['firstLetter'],
                                          //animationController: _buildAnimationController(),
                                          createDate: (documents[index]['date'])
                                              .toDate());
                                    } else {
                                      if (documents[index]['type'] == "image") {
                                        return ReceiveMsgMultimediaBox(
                                            type: "image",
                                            urlImage: documents[index]['url'],
                                            firstLetter: documents[index]
                                                ['firstLetter'],
                                            //animationController: _buildAnimationController(),
                                            createDate: (documents[index]
                                                    ['date'])
                                                .toDate());
                                      } else {
                                        return ReceiveMsgMultimediaBox(
                                            type: "file",
                                            urlImage: documents[index]['url'],
                                            firstLetter: documents[index]
                                                ['firstLetter'],
                                            //animationController: _buildAnimationController(),
                                            createDate: (documents[index]
                                                    ['date'])
                                                .toDate());
                                      }
                                    }
                                  }
                                });
                        }
                      },
                    ),
                  )
                : Expanded(child: SizedBox()),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                    width: 1.0, color: ColorConstants.principalColor),
              )),
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
                color: Colors.black38,
                icon: Icon(Icons.photo_library_rounded),
                onPressed: () => _onImageButtonPressed(ImageSource.gallery,
                    isMultiImage: true)),
            IconButton(
                color: Colors.black38,
                icon: Icon(Icons.attach_file_rounded),
                onPressed: () => _onFileButtonPressed()),
            IconButton(
                color: Colors.black38,
                icon: Icon(Icons.camera_alt_outlined),
                onPressed: () => _onImageButtonPressed(ImageSource.camera)),
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                style: ThemeConfig.bodyText2,
                decoration: InputDecoration(
                  hintText: 'Send a message',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ))
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // setState(() {
    //   _messages.insert(0, message);
    // });

    _focusNode.requestFocus();
    //message.animationController.forward();

    _isSelf = !_isSelf;
    if (widget.roomChat.id == null) {
      await controller.createRoom(widget.roomChat.product!).then((value) {
        widget.roomChat.id = value.id;
        print("---------------------${widget.roomChat.id}");
        controller.sendMessage(text, widget.roomChat.id!);
        collectionRoom = firestore.collection("ChatRoom${widget.roomChat.id}");
      });
    }
    collectionRoom.add({
      'type': 'text',
      'url': '',
      'message': text,
      'user': controller.userStrapi.value!.id,
      'date': DateTime.now(),
      'firstLetter':
          controller.userStrapi.value!.nameLastname.toString()[0].toUpperCase(),
    });
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage(
          maxWidth: 300,
          maxHeight: 300,
          imageQuality: 50,
        );
        //controller.imagesToUpload.value = pickedFileList;
        if (widget.roomChat.id == null) {
          controller.createRoom(widget.roomChat.product!).then((value) async {
            widget.roomChat.id = value.id;
            pickedFileList.forEach((element) async {
              await controller
                  .sendMessage('image', value.id!, type: 'image')
                  .then((chat) async {
                // controller
                //     .sendMultimediaMessage(File(element.path), chat.id!)
                //     .then((imageUploaded) {
                //   var message = SendMsgMultimediaBox(
                //     urlImage: imageUploaded.url,
                //     firstLetter: controller.userStrapi.value!.nameLastname
                //         .toString()[0]
                //         .toUpperCase(),
                //     animationController: _buildAnimationController(),
                //     createDate: chat.createdAt!,
                //   );
                //   setState(() {
                //     _messages.insert(0, message);
                //   });
                //   message.animationController.forward();
                // });
              });
            });
          });
        } else {
          pickedFileList.forEach((element) async {
            String downloadUrl = '';
            Reference storageReference =
                FirebaseStorage.instance.ref().child(element.path);
            UploadTask uploadTask =
                storageReference.putFile(File(element.path));

            TaskSnapshot taskSnapshot = await uploadTask;

            if (taskSnapshot.state == TaskState.success) {
              downloadUrl = await storageReference.getDownloadURL();
            }
            collectionRoom.add({
              'type': 'image',
              'url': downloadUrl,
              'message': '',
              'user': controller.userStrapi.value!.id,
              'date': DateTime.now(),
              'firstLetter': controller.userStrapi.value!.nameLastname
                  .toString()[0]
                  .toUpperCase(),
            });
            // await controller
            //     .sendMessage('image', widget.roomChat.id!, type: 'image')
            //     .then((chat) async {
            //   await controller
            //       .sendMultimediaMessage(File(element.path), chat.id!)
            //       .then((imageUploaded) {
            //     var message = SendMsgMultimediaBox(
            //       urlImage: imageUploaded.url,
            //       firstLetter: controller.userStrapi.value!.nameLastname
            //           .toString()[0]
            //           .toUpperCase(),
            //       animationController: _buildAnimationController(),
            //       createDate: chat.createdAt!,
            //     );
            //     setState(() {
            //       _messages.insert(0, message);
            //     });
            //     message.animationController.forward();
            //   });
            // });
          });
        }
      } catch (e) {
        // setState(() {
        //   _pickImageError = e.toString();
        // });
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 300,
          maxHeight: 300,
          imageQuality: 50,
        );
        controller.imagesToUpload.add(pickedFile!);

        if (widget.roomChat.id == null) {
          controller.createRoom(widget.roomChat.product!).then((value) async {
            widget.roomChat.id = value.id;

            // await controller
            //     .sendMessage('image', value.id!, type: 'image')
            //     .then((chat) async {
            //   await controller
            //       .sendMultimediaMessage(File(pickedFile.path), chat.id!)
            //       .then((imageUploaded) {
            //     var message = SendMsgMultimediaBox(
            //       urlImage: imageUploaded.url,
            //       firstLetter: controller.userStrapi.value!.nameLastname
            //           .toString()[0]
            //           .toUpperCase(),
            //       animationController: _buildAnimationController(),
            //       createDate: DateTime.now(),
            //     );
            //     setState(() {
            //       _messages.insert(0, message);
            //     });
            //     message.animationController.forward();
            //   });
            // });
          });
        } else {
          String downloadUrl = '';
          Reference storageReference =
              FirebaseStorage.instance.ref().child(pickedFile.path);
          UploadTask uploadTask =
              storageReference.putFile(File(pickedFile.path));

          TaskSnapshot taskSnapshot = await uploadTask;

          if (taskSnapshot.state == TaskState.success) {
            downloadUrl = await storageReference.getDownloadURL();
          }
          collectionRoom.add({
            'type': 'image',
            'url': downloadUrl,
            'message': '',
            'user': controller.userStrapi.value!.id,
            'date': DateTime.now(),
            'firstLetter': controller.userStrapi.value!.nameLastname
                .toString()[0]
                .toUpperCase(),
          });
          // await controller
          //     .sendMessage('image', widget.roomChat.id!, type: 'image')
          //     .then((chat) async {
          //   await controller
          //       .sendMultimediaMessage(File(pickedFile.path), chat.id!)
          //       .then((imageUploaded) {
          //     var message = SendMsgMultimediaBox(
          //       urlImage: imageUploaded.url,
          //       firstLetter: controller.userStrapi.value!.nameLastname
          //           .toString()[0]
          //           .toUpperCase(),
          //       animationController: _buildAnimationController(),
          //       createDate: chat.createdAt!,
          //     );
          //     setState(() {
          //       _messages.insert(0, message);
          //     });
          //     message.animationController.forward();
          //   });
          // });
        }
      } catch (e) {}
    }
  }

  void _onFileButtonPressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      String downloadUrl = '';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(file.path);
      UploadTask uploadTask = storageReference.putFile(File(file.path));

      TaskSnapshot taskSnapshot = await uploadTask;

      if (taskSnapshot.state == TaskState.success) {
        downloadUrl = await storageReference.getDownloadURL();
      }
      collectionRoom.add({
        'type': 'file',
        'url': downloadUrl,
        'message': '',
        'user': controller.userStrapi.value!.id,
        'date': DateTime.now(),
        'firstLetter': controller.userStrapi.value!.nameLastname
            .toString()[0]
            .toUpperCase(),
      });
      // await controller
      //     .sendMessage('file', widget.roomChat.id!, type: 'file')
      //     .then((chat) async {
      //   await controller
      //       .sendMultimediaMessage(File(file.path), chat.id!)
      //       .then((imageUploaded) {
      //     var message = SendMsgMultimediaBox(
      //         urlImage: imageUploaded.url,
      //         firstLetter: controller.userStrapi.value!.nameLastname
      //             .toString()[0]
      //             .toUpperCase(),
      //         animationController: _buildAnimationController(),
      //         createDate: chat.createdAt!,
      //         type: 'file');
      //     setState(() {
      //       _messages.insert(0, message);
      //     });
      //     message.animationController.forward();
      //   });
      // });
    } else {
      // User canceled the picker
    }
  }

}
