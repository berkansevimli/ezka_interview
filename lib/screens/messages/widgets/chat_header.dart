import 'package:ezka_interview/screens/profile_screen/model/fetch_datas.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../profile_screen/widgets/profile_pic.dart';
import '../Screens/chat_screen.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({
    Key? key,
    required this.widget,
    required this.buildContext,
  }) : super(key: key);

  final ChatPage widget;
  final BuildContext buildContext;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            buildContext,
            MaterialPageRoute(
                builder: (builder) => GetUserInfos(userID: widget.user.uid!)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
                height: 32,
                width: 32,
                child: ProfilePic(
                    isSettings: false, isProfile: true, img: widget.user.img!)),
            SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.firstname!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
