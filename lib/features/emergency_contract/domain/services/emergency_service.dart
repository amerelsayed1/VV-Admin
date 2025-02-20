import 'package:vv_admin/common/basewidgets/custom_snackbar_widget.dart';
import 'package:vv_admin/data/model/response/base/api_response.dart';
import 'package:vv_admin/data/model/response/response_model.dart';
import 'package:vv_admin/features/emergency_contract/domain/models/emergency_contact_model.dart';
import 'package:vv_admin/features/emergency_contract/domain/repositories/emergency_contract_repository_interface.dart';
import 'package:vv_admin/features/emergency_contract/domain/services/emergency_contruct_service_interface.dart';
import 'package:vv_admin/helper/api_checker.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/main.dart';

class EmergencyService implements EmergencyServiceInterface{
  EmergencyContractRepositoryInterface emergencyContractRepoInterface;
  EmergencyService({required this.emergencyContractRepoInterface});

  @override
  Future addNewEmergencyContact(String name, String phone, int? id, {bool isUpdate = false}) async {
    ApiResponse response = await emergencyContractRepoInterface.addNewEmergencyContact(name, phone, id, isUpdate: isUpdate);
    if(response.response!.statusCode == 200) {
      isUpdate ? showCustomSnackBarWidget(getTranslated("contact_updated_successfully", Get.context!), Get.context!, isError: false,  sanckBarType: SnackBarType.success):
      showCustomSnackBarWidget(getTranslated("contact_added_successfully", Get.context!), Get.context!, isError: false);
      return ResponseModel(true, '');
    }else {
      return ResponseModel(false, '');
    }
  }

  @override
  Future deleteEmergencyContact(int? id) async{
    ApiResponse apiResponse = await emergencyContractRepoInterface.delete(id!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      String? message = apiResponse.response!.data['message'];
      showCustomSnackBarWidget(message, Get.context!, isError: false,  sanckBarType: SnackBarType.success);
      return ResponseModel(true, message);
    }else{
      String? message = apiResponse.response!.data['message'];
      showCustomSnackBarWidget(message, Get.context!,  sanckBarType: SnackBarType.error);
      return ResponseModel(false, message);
    }
  }

  @override
  Future getEmergencyContactList(String? key) async{
    ApiResponse apiResponse = await emergencyContractRepoInterface.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     return EmergencyContactModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }


  @override
  Future getEmergencyContactListSearch(String? key) async{
    ApiResponse apiResponse = await emergencyContractRepoInterface.getEmergencyContactListSearch(key!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      return EmergencyContactModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  @override
  Future statusOnOffEmergencyContact(int? id, int status) async{
    ApiResponse apiResponse = await emergencyContractRepoInterface.statusOnOffEmergencyContact(id, status);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      showCustomSnackBarWidget(map['message'], Get.context!, isToaster: true, isError: false);
      return ResponseModel(true, map['message']);
    }else{
      Map map = apiResponse.response!.data;
      showCustomSnackBarWidget(map['message'], Get.context!, isToaster: true);
      return ResponseModel(false, map['message']);
    }
  }

}