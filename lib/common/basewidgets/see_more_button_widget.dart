import 'package:flutter/material.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';

class SeeMoreButtonWidget extends StatelessWidget {
  const SeeMoreButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
        child: Container(width: 125,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: ThemeShadow.getShadow(context),
              borderRadius: BorderRadius.circular(100)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              const Icon(Icons.arrow_drop_down,color: Colors.white,),
              Text(getTranslated('see_more', context)!, style: robotoRegular.copyWith(color: Colors.white),)
            ],),
          ),),
      ),
    );
  }
}
