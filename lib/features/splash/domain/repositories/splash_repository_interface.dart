

import 'package:flutter/cupertino.dart';
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class SplashRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getConfig();
  void initSharedData();
  String getCurrency();
  void setCurrency(String currencyCode);
  void setShippingType(String shippingType);
  Future<ApiResponse> getShippingTypeList(BuildContext context, String type);
}