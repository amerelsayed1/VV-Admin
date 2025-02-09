import 'package:flutter/material.dart';
import 'package:vv_admin/features/order/domain/models/order_model.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/common/basewidgets/custom_image_widget.dart';


class CustomerContactWidget extends StatelessWidget {
  final Order? orderModel;
  const CustomerContactWidget({Key? key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: ThemeShadow.getShadow(context)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        orderModel!.isGuest! ?
        Text('${getTranslated('customer_information', context)} (${getTranslated('guest_customer', context)})',
            style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
              fontSize: Dimensions.fontSizeLarge,)):
        Text('${getTranslated('customer_information', context)}',
            style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
              fontSize: Dimensions.fontSizeLarge,)),
        const SizedBox(height: Dimensions.paddingSizeDefault),


        Row( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(50),
            child: CustomImageWidget( height: 50,width: 50, fit: BoxFit.cover,
            image: '${orderModel?.customer?.imageFullPath?.path}')),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(orderModel!.isGuest! ? '${orderModel!.shippingAddressData != null? orderModel!.shippingAddressData?.contactPersonName :
            '${orderModel?.billingAddressData?.contactPersonName}'}' :
            '${orderModel!.customer?.fName ?? ''} ''${orderModel!.customer?.lName ?? ''}',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            Row(
              children: [
                Image.asset(Images.phone, width: 15),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Text(orderModel!.isGuest! ? '${orderModel!.shippingAddressData != null? orderModel!.shippingAddressData?.phone :
                '${orderModel?.billingAddressData?.phone}'}' :
                '${orderModel!.customer?.phone}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
              ],
            ),


            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


            Row(
              children: [
                Image.asset(Images.email, width: 15),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                orderModel!.isGuest! ?
                Text('${orderModel!.shippingAddressData != null? orderModel!.shippingAddressData?.email :
                '${orderModel?.billingAddressData?.email}'}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)):
                Text(orderModel!.customer?.email ?? '',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
              ],
            ),

            ],))
        ],
        )
      ]),
    );
  }
}
