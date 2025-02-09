import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/chat/screens/inbox_screen.dart';
import 'package:vv_admin/features/maintenance/maintenance_screen.dart';
import 'package:vv_admin/features/notification/screens/notification_screen.dart';
import 'package:vv_admin/features/order_details/screens/order_details_screen.dart';
import 'package:vv_admin/features/product/screens/product_list_screen.dart';
import 'package:vv_admin/features/refund/domain/models/refund_model.dart';
import 'package:vv_admin/features/refund/screens/refund_details_screen.dart';
import 'package:vv_admin/features/wallet/screens/wallet_screen.dart';
import 'package:vv_admin/helper/network_info.dart';
import 'package:vv_admin/features/auth/controllers/auth_controller.dart';
import 'package:vv_admin/features/splash/controllers/splash_controller.dart';
import 'package:vv_admin/main.dart';
import 'package:vv_admin/notification/models/notification_body.dart';
import 'package:vv_admin/utill/app_constants.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/features/auth/screens/auth_screen.dart';
import 'package:vv_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:vv_admin/features/splash/widgets/splash_painter_widget.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;

  const SplashScreen({Key? key, this.body}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(Get.context!, listen: false)
        .setUnAuthorize(false, update: false);
    initCall();
  }

  Future<void> initCall() async {
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashController>(context, listen: false)
        .initConfig()
        .then((bool isSuccess) {
      if (isSuccess) {
        Provider.of<SplashController>(context, listen: false)
            .initShippingTypeList(context, '');
        Timer(const Duration(seconds: 1), () async {
          final config =
              Provider.of<SplashController>(Get.context!, listen: false)
                  .configModel;
          if (config?.maintenanceModeData?.maintenanceStatus == 1 &&
              config?.maintenanceModeData?.selectedMaintenanceSystem
                      ?.vendorApp ==
                  1) {
            Navigator.of(Get.context!).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const MaintenanceScreen(),
                settings: const RouteSettings(name: 'MaintenanceScreen'),
              ),
            );
          } else {
            if (widget.body != null) {
              String notificationType = widget.body?.type ?? "";

              switch (notificationType.toLowerCase()) {
                case 'chatting':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => InboxScreen(
                                fromNotification: true,
                                initIndex: widget.body?.messageKey ==
                                        'message_from_delivery_man'
                                    ? 1
                                    : 0)));
                  }
                  break;

                case 'theme':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  }
                  break;

                case 'order':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                                orderId:
                                    int.parse(widget.body!.orderId.toString()),
                                fromNotification: true)));
                  }
                  break;

                case 'wallet':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                const WalletScreen(fromNotification: true)));
                  }
                  break;

                case 'wallet_withdraw':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                const WalletScreen(fromNotification: true)));
                  }
                  break;

                case 'product_request_approved_message':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const ProductListMenuScreen(
                                fromNotification: true)));
                  }
                  break;

                case 'refund':
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => RefundDetailsScreen(
                                fromNotification: true,
                                refundModel:
                                    RefundModel(id: widget.body!.refundId),
                                orderDetailsId: widget.body!.orderDetailsId)));
                  }
                  break;

                default:
                  {
                    Navigator.of(Get.context!).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  }
                  break;
              }
            } else {
              if (Provider.of<AuthController>(context, listen: false)
                  .isLoggedIn()) {
                await Provider.of<AuthController>(context, listen: false)
                    .updateToken(context);
                Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const DashboardScreen()));
              } else {
                Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const AuthScreen()));
              }
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: SplashPainterWidget(),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      Images.logo,
                      fit: BoxFit.cover,
                      width: 180.0,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Text(
                    AppConstants.appName,
                    style: titilliumBold.copyWith(
                        fontSize: Dimensions.fontSizeWallet,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
