import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/common/basewidgets/custom_snackbar_widget.dart';
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/main.dart';
import 'package:vv_admin/features/auth/controllers/auth_controller.dart';
import 'package:vv_admin/features/auth/screens/auth_screen.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if(apiResponse.error.toString() == 'unauthorized') {
      Provider.of<AuthController>(Get.context!,listen: false).clearSharedData();

      if(Provider.of<AuthController>(Get.context!,listen: false).isUnAuthorize == false) {
        print("==401==>>Inside");
        try {
          Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
        } catch( ex) {
          print("===RouteException==>>$ex");
        }
      }
      Provider.of<AuthController>(Get.context!,listen: false).setUnAuthorize(true, update: true);

      // Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
    }else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      if(errorMessage != ''){
        showCustomSnackBarWidget(errorMessage, Get.context!, sanckBarType: SnackBarType.error);
      }
    }
  }
}