import 'dart:io';
import 'package:vv_admin/features/profile/domain/models/profile_body.dart';
import 'package:vv_admin/features/profile/domain/models/profile_info.dart';

abstract class ProfileServiceInterface {
  Future<dynamic> getSellerInfo();
  Future<dynamic> updateProfile(ProfileInfoModel userInfoModel, ProfileBody seller,  File? file, String token, String password);
  Future<dynamic> deleteUserAccount();
}