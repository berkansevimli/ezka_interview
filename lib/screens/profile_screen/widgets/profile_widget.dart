import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  final bool isLoadingImg;

  const ProfileWidget(
      {Key? key,
      required this.imagePath,
      required this.onClicked,
      this.isEdit = false,
      this.isLoadingImg = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: isLoadingImg
            ? Container(
                width: 96, height: 96, child: CircularProgressIndicator())
            : InkWell(
                onTap: onClicked,
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  width: 96,
                  height: 96,
                  imageUrl: imagePath,
                  placeholder: (context, url) =>
                       CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Image.asset("assets/images/person.png"),
                ),
              ),
      ),
    );
  }

}
 
