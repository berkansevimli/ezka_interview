import 'package:ezka_interview/screens/messages/widgets/text_message.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../profile_screen/widgets/profile_pic.dart';
import '../models/ChatMessage.dart';
import 'image_mesage.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.userIMG,
  }) : super(key: key);

  final ChatMessage message;
  final String userIMG;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case "text":
          return TextMessage(message: message);
        case "img":
          return ImageMessage(message: message);

        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                  height: 32.0,
                  width: 32.0,
                  child: ProfilePic(
                    img: userIMG,
                    isProfile: true,
                    isSettings: false,
                  )),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
          // if (message.isSender) MessageStatusDot(status:MessageStatus.viewed)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kSecondaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 0,right: 4),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
