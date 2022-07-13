import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../models/ChatMessage.dart';
import '../utils.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    bool isSender = message!.isSender;
    String type = message!.messageType;
    String img = message!.mediaUrl;
    return Padding(
      padding: EdgeInsets.only(right: isSender ? 8.0 : 0.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth / 1.5),
      
        decoration: BoxDecoration(
          color:  isSender
              ? Theme.of(context).highlightColor
              : Theme.of(context).canvasColor,

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isSender ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isSender ? Radius.circular(0) : Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => ImageProfile(url: img)));
              },
              child: Container(
                
                decoration: BoxDecoration(
                border: Border.all(width: 2, color: isSender
              ? Theme.of(context).highlightColor
              : Theme.of(context).canvasColor,
),
                  //color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isSender ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isSender ? Radius.circular(0) : Radius.circular(12)),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    imageUrl: img,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                          height: 48,
                          width: 48,
                          child: new Image.asset('assets/icons/loading.gif')),
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                // Image(image: NetworkImage(img!), fit: BoxFit.cover,),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                Utils.toTime(message!.messageTime),
                style: isSender
                    ? TextStyle(fontSize: 10)
                    : TextStyle(
                        fontSize: 10,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
