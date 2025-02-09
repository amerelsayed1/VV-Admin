

import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/features/settings/domain/models/business_model.dart';
import 'package:vv_admin/features/settings/domain/repositories/buisness_repository_interface.dart';
import 'package:vv_admin/features/settings/domain/services/business_service_interface.dart';
import 'package:vv_admin/helper/api_checker.dart';

class BusinessService implements BusinessServiceInterface{
  final BusinessRepositoryInterface businessRepoInterface;
  BusinessService({required this.businessRepoInterface});

  @override
  Future getBusinessList() async{
    List<BusinessModel>? businessList;
    ApiResponse apiResponse = await businessRepoInterface.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      businessList = [];
      apiResponse.response!.data.forEach((business) => businessList!.add(business));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    return businessList;
  }
}