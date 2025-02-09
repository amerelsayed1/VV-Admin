import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:vv_admin/common/basewidgets/custom_snackbar_widget.dart';
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/features/barcode/domain/services/barcode_service_interface.dart';
import 'package:vv_admin/helper/api_checker.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/main.dart';

class BarcodeController extends ChangeNotifier{

  final BarcodeServiceInterface barcodeServiceInterface;
  BarcodeController({required this.barcodeServiceInterface});


  int _barCodeQuantity = 0;
  int get barCodeQuantity => _barCodeQuantity;
  bool _isGetting = false;
  bool get isGetting => _isGetting;
  String? _printBarCode = '';
  String? get printBarCode =>_printBarCode;


  void setBarCodeQuantity(int quantity){
    _barCodeQuantity = quantity;
    if (kDebugMode) {
      print('Quantity is ==>$_barCodeQuantity');
    }
    notifyListeners();
  }

  Future<void> barCodeDownload(BuildContext context,int? id, int quantity) async {
    _isGetting = true;
    ApiResponse apiResponse = await barcodeServiceInterface.barCodeDownLoad(id, quantity);
    if(apiResponse.response!.statusCode == 200) {
      _printBarCode = apiResponse.response!.data;
      showCustomSnackBarWidget(getTranslated('barcode_downloaded_successfully', Get.context!),Get.context!,isError: false);

      _isGetting = false;
    }else {
      ApiChecker.checkApi(apiResponse);
    }
    _isGetting = false;
    notifyListeners();
  }
  
}