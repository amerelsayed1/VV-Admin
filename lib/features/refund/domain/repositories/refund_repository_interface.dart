
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class RefundRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getRefundReqDetails(int? orderDetailsId);
  Future<ApiResponse> refundStatus(int? refundId , String status, String note);
  Future<ApiResponse> getRefundStatusList(String type);
  Future<ApiResponse> getSingleRefundModel(int? refundId);
}