
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/transaction/domain/models/transaction_model.dart';
import 'package:vv_admin/helper/date_converter.dart';
import 'package:vv_admin/helper/price_converter.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/theme/controllers/theme_controller.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionWidget({Key? key, required this.transactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall),
      child: Column(crossAxisAlignment : CrossAxisAlignment.start, children: [

          Container( padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraSmall), topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Text('${getTranslated('transaction_id', context)}# ${transactionModel.id}',
                style: titilliumBold.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault),),
              Container( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  border: Border.all(color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
                  color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor.withValues(alpha:0):
                  Theme.of(context).primaryColor.withValues(alpha:.07),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                child: Text(PriceConverter.convertPrice(context, transactionModel.amount),
                  style: robotoBold.copyWith(
                      color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withValues(alpha:.7),
                      fontSize: Dimensions.fontSizeDefault),),
              ),



            ]),
          ),

         const SizedBox(height: Dimensions.paddingSizeVeryTiny),

         Container(width: MediaQuery.of(context).size.width,
           padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
           decoration: BoxDecoration(
               borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeExtraSmall), bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
               color: Theme.of(context).cardColor,
               boxShadow: ThemeShadow.getShadow(context)
           ),
           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(transactionModel.createdAt!)),
               style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                   fontSize: Dimensions.fontSizeDefault)),
             const SizedBox(height: Dimensions.paddingSizeSmall),
             Row(
               children: [
                 SizedBox(width: Dimensions.iconSizeSmall,
                     child: Image.asset( transactionModel.approved == 1 ? Images.approveIcon:transactionModel.approved == 2? Images.declineIcon: Images.pendingIcon)),
                 Padding(
                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                   child: Text(getTranslated(transactionModel.approved == 2 ?
                   'denied' : transactionModel.approved == 1 ? 'approved' : 'pending', context)!,
                     style: titilliumRegular.copyWith(color: transactionModel.approved == 1 ? Colors.green : transactionModel.approved == 2 ?
                     Colors.red : Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
                 ),
               ],
             ),
           ],),)


        ],
      ),
    );
  }
}
