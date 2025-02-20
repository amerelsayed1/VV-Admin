import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/barcode/controllers/barcode_controller.dart';
import 'package:vv_admin/features/clearance_sale/controllers/clearance_sale_controller.dart';
import 'package:vv_admin/features/notification/controllers/notification_controller.dart';
import 'package:vv_admin/features/order_details/controllers/order_details_controller.dart';
import 'package:vv_admin/features/product/widgets/cookies_widget.dart';
import 'package:vv_admin/features/product_details/controllers/productDetailsController.dart';
import 'package:vv_admin/features/restock/controllers/restock_controller.dart';
import 'package:vv_admin/features/wallet/controllers/wallet_controller.dart';
import 'package:vv_admin/localization/app_localization.dart';
import 'package:vv_admin/features/auth/controllers/auth_controller.dart';
import 'package:vv_admin/features/settings/controllers/business_controller.dart';
import 'package:vv_admin/features/pos/controllers/cart_controller.dart';
import 'package:vv_admin/features/chat/controllers/chat_controller.dart';
import 'package:vv_admin/features/coupon/controllers/coupon_controller.dart';
import 'package:vv_admin/features/delivery_man/controllers/delivery_man_controller.dart';
import 'package:vv_admin/features/emergency_contract/controllers/emergency_contact_controller.dart';
import 'package:vv_admin/features/language/controllers/language_controller.dart';
import 'package:vv_admin/localization/controllers/localization_controller.dart';
import 'package:vv_admin/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:vv_admin/features/order/controllers/location_controller.dart';
import 'package:vv_admin/features/order/controllers/order_controller.dart';
import 'package:vv_admin/features/product/controllers/product_controller.dart';
import 'package:vv_admin/features/review/controllers/product_review_controller.dart';
import 'package:vv_admin/features/profile/controllers/profile_controller.dart';
import 'package:vv_admin/features/refund/controllers/refund_controller.dart';
import 'package:vv_admin/features/addProduct/controllers/add_product_controller.dart';
import 'package:vv_admin/features/shipping/controllers/shipping_controller.dart';
import 'package:vv_admin/features/shop/controllers/shop_controller.dart';
import 'package:vv_admin/features/splash/controllers/splash_controller.dart';
import 'package:vv_admin/notification/models/notification_body.dart';
import 'package:vv_admin/theme/controllers/theme_controller.dart';
import 'package:vv_admin/features/bank_info/controllers/bank_info_controller.dart';
import 'package:vv_admin/features/transaction/controllers/transaction_controller.dart';
import 'package:vv_admin/theme/dark_theme.dart';
import 'package:vv_admin/theme/light_theme.dart';
import 'package:vv_admin/utill/app_constants.dart';
import 'package:vv_admin/features/splash/screens/splash_screen.dart';
import 'di_container.dart' as di;
import 'firebase_options.dart';
import 'notification/my_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(debug: true , ignoreSsl: true);
  await di.init();


  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  NotificationBody? body;

  try {
    final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      body = NotificationBody.fromJson(remoteMessage.data);
    }
  } catch(e) {
    if (kDebugMode) {
      print(e);
    }
  }

  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeController>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopController>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BankInfoController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BusinessController>()),
      ChangeNotifierProvider(create: (context) => di.sl<TransactionController>()),
      ChangeNotifierProvider(create: (context) => di.sl<AddProductController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductReviewController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShippingController>()),
      ChangeNotifierProvider(create: (context) => di.sl<DeliveryManController>()),
      ChangeNotifierProvider(create: (context) => di.sl<RefundController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BottomMenuController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartController>()),
      ChangeNotifierProvider(create: (context) => di.sl<EmergencyContactController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<WalletController>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderDetailsController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductDetailsController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BarcodeController>()),
      ChangeNotifierProvider(create: (context) => di.sl<RestockController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ClearanceSaleController>())
    ],
    child: MyApp(body: body),
  ));
}

class MyApp extends StatelessWidget {
  final NotificationBody? body;
  const MyApp({Key? key, this.body}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeController>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationController>(context).locale,
      builder:(context,child){
        return Consumer<ProductController>(
            builder: (context, productController, _){
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: Stack(children: [
                child!,
                if(
                  productController.stockLimitStatus != null
                  && Provider.of<AuthController>(context, listen: false).isLoggedIn()
                  && productController.showCookies
                  && !productController.isShowCookies()
                  && (productController.stockLimitStatus?.productCount ?? 0) < 0
                )
                const Positioned.fill(child: Align(alignment: Alignment.bottomCenter, child: CookiesWidget())),
              ]),
            );
          }
        );
      },
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locals,
      home: SplashScreen(body: body),
    );
  }
}
class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}