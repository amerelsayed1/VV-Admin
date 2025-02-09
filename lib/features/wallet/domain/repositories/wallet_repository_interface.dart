

import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class WalletRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getDynamicWithDrawMethod();
  Future<ApiResponse> withdrawBalance(List <String?> typeKey, List<String> typeValue, int? id, String balance);

}