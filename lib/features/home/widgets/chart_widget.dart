import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/bank_info/controllers/bank_info_controller.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/features/home/widgets/transaction_chart_widget.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: ColorResources.getPrimary(context).withValues(alpha:.05),
              spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
      ),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeSmall),
        child: Consumer<BankInfoController>(builder: (context, bankInfo, child) {


          return (bankInfo.userCommissions!=null && bankInfo.userEarnings != null)?
          const TransactionChart():const SizedBox();
        }),
      ),
    );
  }
}
