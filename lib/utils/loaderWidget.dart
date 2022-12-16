import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
      height: sizeSettings.fullHeight,
      width: sizeSettings.fullWidth,
      alignment: Alignment.center,
      color: Colors.grey.withOpacity(0.5),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: SpinKitDualRing(
            color: kPrimaryYellow,
            lineWidth: 3,
            size: 28,
          ),
        ),
      ),
    ));
  }
}
