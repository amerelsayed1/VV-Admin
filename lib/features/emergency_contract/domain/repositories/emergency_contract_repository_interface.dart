import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/interface/repository_interface.dart';

abstract class EmergencyContractRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> addNewEmergencyContact(String name, String phone,int? id, {bool isUpdate = false});
  Future<ApiResponse> statusOnOffEmergencyContact(int? id, int status);
  Future<ApiResponse> getEmergencyContactListSearch(String key);
}