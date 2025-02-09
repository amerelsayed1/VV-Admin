

import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class TransactionRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getTransactionList(String status, String from, String to);
  Future<ApiResponse> getMonthTypeList();
  Future<ApiResponse> getYearList();
}