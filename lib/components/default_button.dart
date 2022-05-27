import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider.dart';
import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<MyProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child: registerProvider.isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),

        //  Text(
        //   text!,
        //   style: TextStyle(

        //   ),
        // ),
      ),
    );
  }
}
