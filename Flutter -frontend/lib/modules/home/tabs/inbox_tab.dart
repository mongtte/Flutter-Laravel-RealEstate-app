import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/modules/chats/inbox_chat_list_screen.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InboxTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.showBadge = false.obs;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('label4_nav'.tr,
              style: TextStyle(fontSize: 21.sp, color: Colors.white)),
          backgroundColor: ColorConstants.principalColor,
          //brightness: Brightness.dark,
        ),
        body: InboxChatListScreen());
  }
}

// class _InboxTabState extends State<InboxTab> with TickerProviderStateMixin {
//   final List<MsgBox> _messages = [];
//   final FocusNode _focusNode = FocusNode();
//   final _textController = TextEditingController();
//   bool _isComposing = false;
//   bool _isSelf = true;

//   @override
//   void initState() {
//     super.initState();
//     _messages.insert(
//         0,
//         SendMsgBox(
//             message: "Hello",
//             animationController: _buildAnimationController()));
//     _messages.insert(
//         0,
//         ReceiveMsgBox(
//             message: "Hi, how are you",
//             animationController: _buildAnimationController()));
//     _messages.insert(
//         0,
//         SendMsgBox(
//             message: "I am great how are you doing",
//             animationController: _buildAnimationController()));
//     _messages.insert(
//         0,
//         ReceiveMsgBox(
//             message: "I am also fine",
//             animationController: _buildAnimationController()));

//     Future.delayed(Duration(milliseconds: 250), () {
//       _focusNode.requestFocus();
//       _messages.forEach((message) {
//         message.animationController.forward();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Messaggi'),
//         backgroundColor: ColorConstants.principalColor,
//         brightness: Brightness.dark,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Flexible(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(8.0),
//                 reverse: true,
//                 itemBuilder: (_, index) => _messages[index],
//                 itemCount: _messages.length,
//               ),
//             ),
//             Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(width: 1.0, color: ColorConstants.principalColor),
//                 )
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           children: [
//             Flexible(
//               child: TextField(
//                 controller: _textController,
//                 onChanged: (text) {
//                   setState(() {
//                     _isComposing = text.isNotEmpty;
//                   });
//                 },
//                 onSubmitted: _isComposing ? _handleSubmitted : null,
//                 decoration:
//                     const InputDecoration.collapsed(hintText: 'Send a message'),
//                 focusNode: _focusNode,
//               ),
//             ),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _isComposing
//                       ? () => _handleSubmitted(_textController.text)
//                       : null,
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     setState(() {
//       _isComposing = false;
//     });

//     var message = _isSelf
//         ? SendMsgBox(
//             message: text,
//             animationController: _buildAnimationController(),
//           )
//         : ReceiveMsgBox(
//             message: text,
//             animationController: _buildAnimationController(),
//           );

//     setState(() {
//       _messages.insert(0, message);
//     });

//     _focusNode.requestFocus();
//     message.animationController.forward();

//     _isSelf = !_isSelf;
//   }

//   AnimationController _buildAnimationController() {
//     return AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//   }
// }
