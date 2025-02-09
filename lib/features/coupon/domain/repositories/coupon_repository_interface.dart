
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/features/coupon/domain/models/coupon_model.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class CouponRepositoryInterface extends RepositoryInterface<Coupons>{
  Future<ApiResponse> updateCouponStatus(int? id, int status);
  Future<ApiResponse> getCouponCustomerList(String search);
  @override
  Future<dynamic> add(Coupons value, {bool update = false});
}