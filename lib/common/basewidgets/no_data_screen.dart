import 'package:flutter/material.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';

class NoDataScreen extends StatelessWidget {
  final String? title;
  final Color? color;
  const NoDataScreen({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(Images.noOrderFound, width: 100, height: 100),
          Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Text(title != null? getTranslated(title, context)!:
              getTranslated('nothing_found', context)!,
              style: robotoRegular.copyWith(color: color ?? Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
