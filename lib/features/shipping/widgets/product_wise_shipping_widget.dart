import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/features/shipping/controllers/shipping_controller.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/common/basewidgets/custom_app_bar_widget.dart';
import 'package:vv_admin/features/shipping/widgets/drop_down_for_shipping_type_widget.dart';

class ProductWiseShippingWidget extends StatefulWidget {
  const ProductWiseShippingWidget({Key? key}) : super(key: key);

  @override
  State<ProductWiseShippingWidget> createState() => _ProductWiseShippingWidgetState();
}

class _ProductWiseShippingWidgetState extends State<ProductWiseShippingWidget> {

  @override
  void initState() {
    Provider.of<ShippingController>(context, listen: false).iniType('product_type');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBarWidget(title: getTranslated('shipping_method', context),isBackButtonExist: true,),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
          const DropDownForShippingTypeWidget(),
          Expanded( child: Column( children: [
                Padding(
                  padding: EdgeInsets.only(
                      top : MediaQuery.of(context).size.height/5),
                  child: SizedBox(width: MediaQuery.of(context).size.width/3,
                      child: Image.asset(Images.productWiseShipping)),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeButton),
                  child: Text(getTranslated('product_wise_delivery_note', context)!,style: robotoRegular.copyWith(),textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
          const SizedBox()

        ],));
  }
}
