import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:vv_admin/helper/date_converter.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/features/refund/controllers/refund_controller.dart';
import 'package:vv_admin/main.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/features/refund/widgets/change_log_widget.dart';
import 'package:vv_admin/features/refund/widgets/refund_details_widget.dart';
import 'package:vv_admin/features/refund/domain/models/refund_model.dart';

class RefundDetailsScreen extends StatefulWidget {
  final RefundModel? refundModel;
  final int? orderDetailsId;
  final String? variation;
  final bool? fromNotification;
  const RefundDetailsScreen({Key? key, this.refundModel, this.orderDetailsId, this.variation, this.fromNotification = false}) : super(key: key);

  @override
  State<RefundDetailsScreen> createState() => _RefundDetailsScreenState();
}

class _RefundDetailsScreenState extends State<RefundDetailsScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;
  RefundModel? refundModel;

  @override
  void initState() {
    super.initState();
    if(widget.fromNotification!){
      Provider.of<RefundController>(context, listen: false).emptyRefundModel();
      Provider.of<RefundController>(context, listen: false).getSingleRefundModel(Get.context!, widget.refundModel?.id);
    } else {
      refundModel = widget.refundModel;
    }
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener((){
      if (kDebugMode) {
        print('my index is${_tabController!.index}');
      }
    });
  }






  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) async{
        if(widget.fromNotification == true) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()), (route)=> false);
        } else {
          return;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            centerTitle: true,
            elevation: 1,
            leading: InkWell(onTap: () {
              if(widget.fromNotification == true) {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()), (route)=> false);
              } else {
                Navigator.of(context).pop();
              }
             },
                child: Icon(CupertinoIcons.back, color: Theme.of(context).textTheme.bodyLarge?.color,)),
            title:  Consumer<RefundController>(
                builder: (context,refundReq,_) {
                return Column(children: [
                  Text('${refundModel?.orderId != null ?  '${getTranslated('order', context)!}#' : ''} ${refundModel?.orderId ?? ' '}', style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),),
                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(refundModel?.createdAt != null ?  DateConverter.localDateToIsoStringAMPM(DateTime.parse(refundModel!.createdAt!)) : ' ',
                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
                ],);
              }
            ),
            actions: [
              Consumer<RefundController>(
                builder: (context,refundReq,_) {
                  return InkWell(onTap: refundModel?.order?.paymentMethod  == null ? null : () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>  ChangeLogWidget(paidBy: refundModel!.order!.paymentMethod??'')));
                    },
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                          Container(width: 35, height: 35, decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                            child: const Center(child: Icon(Icons.history, color: Colors.white, size: 20,)),),
                        ],
                      ),
                    ),
                  );
                }
              )],
          ),


          body: Consumer<RefundController>(
              builder: (context,refundReq,_) {
                if(widget.fromNotification! && widget.refundModel?.status == null){
                  refundModel = refundReq.refundModel;
                }
                return (widget.fromNotification! &&  refundReq.refundModel == null)  ? const Center(child: CircularProgressIndicator()) : RefundDetailWidget(refundModel: refundModel, orderDetailsId: widget.orderDetailsId, variation: widget.variation);
              }
          )
      ),
    );
  }
}
