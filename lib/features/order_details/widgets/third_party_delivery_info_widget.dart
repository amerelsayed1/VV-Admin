import 'package:flutter/material.dart';
import 'package:vv_admin/features/order/domain/models/order_model.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/common/basewidgets/custom_image_widget.dart';

class ThirdPartyDeliveryInfoWidget extends StatelessWidget {
  final Order? orderModel;
  const ThirdPartyDeliveryInfoWidget({Key? key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)

      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('third_party_information', context)!,
            style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
              fontSize: Dimensions.fontSizeLarge,)),
        const SizedBox(height: Dimensions.paddingSizeDefault),


        Row(children: [ClipRRect(borderRadius: BorderRadius.circular(50),
            child: const CustomImageWidget( height: 50,width: 50, fit: BoxFit.cover,
                image: '')),
          const SizedBox(width: Dimensions.paddingSizeSmall),



          Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(orderModel?.thirdPartyServiceName ?? '',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
            Text(orderModel?.thirdPartyTrackingId ?? '',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),


          ],))
        ],
        )
      ]),
    );
  }
}
