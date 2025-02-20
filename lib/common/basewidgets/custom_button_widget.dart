import 'package:flutter/material.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final bool isColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? borderColor;
  final double? borderRadius;
  const CustomButtonWidget({Key? key, this.onTap, required this.btnTxt, this.backgroundColor, this.isColor = false, this.fontColor, this.borderRadius, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container( height: 40, alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isColor? backgroundColor : backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius != null? borderRadius! : Dimensions.paddingSizeExtraSmall),
          border: Border.all(color: borderColor ?? Theme.of(context).cardColor)
        ),
        child: Text(btnTxt!,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: fontColor ?? Colors.white,
            )),
      ),
    );
  }
}
