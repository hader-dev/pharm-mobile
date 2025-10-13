import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/user/mappers/json_to_user.dart';
import 'package:hader_pharm_mobile/utils/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import '../../../features/common_features/edit_profile/hooks_data_model/edit_profile_form.dart'
    show EditProfileFormDataModel;
import '../../../models/user.dart';
import '../../../utils/urls.dart';
import 'user_repository.dart';

class UserRepository implements IUserRepository {
  final INetworkService client;
  UserRepository({required this.client});

  @override
  Future<String> login(
    String username,
    String password,
  ) async {
    var decodedResponse = await client.sendRequest(() => client.post(Urls.logIn,
        payload: <String, String>{"email": username, "password": password}));

    return decodedResponse["accessToken"];
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    var decodedResponse = await client.sendRequest(() => client.get(Urls.me));

    return jsonToUser(decodedResponse);
  }

  @override
  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    await client.sendRequest(() => client.post(Urls.changePassword, payload: {
          "currentPassword": currentPassword,
          "newPassword": newPassword
        }));
  }

  @override
  Future<String> emailSignUp(String email, String fullName, String password,
      {String? userImagePath}) async {
    late MultipartFile file;
    if (userImagePath != null) {
      String fileName = userImagePath.split('/').last;

      String fileExtension = fileName.split('.').last.toLowerCase();
      String mimeType = getMimeTypeFromExtension(fileExtension);

      debugPrint("SignUp - Image file: $mimeType");
      file = await MultipartFile.fromFile(
        userImagePath,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );
    }
    FormData formData = FormData.fromMap({
      "email": email,
      "fullName": fullName,
      "password": password,
      if (userImagePath != null) ...{
        'image': file,
      }
    });
    var decodedResponse = await client.sendRequest(() => client.post(
          Urls.signUp,
          payload: formData,
          headers: {'Content-Type': 'multipart/form-data'},
        ));

    return decodedResponse["message"];
  }

  @override
  Future<String> sendUserEmailCheckOtpCode(
      {required String email, required String otp}) async {
    var decodedResponse = await client.sendRequest(() => client.post(
        Urls.verifyEmail,
        payload: <String, String>{"email": email, "otp": otp}));

    return decodedResponse["accessToken"];
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await client.sendRequest(
        () => client.post(Urls.resendOtp, payload: <String, String>{
              "email": email,
            }));
  }

  @override
  Future<void> updateProfile(
      {required EditProfileFormDataModel updatedProfileData,
      bool shouldRemoveImage = false}) async {
    try {
      bool hasImage = updatedProfileData.imagePath?.isNotEmpty == true;

      MultipartFile? file;
      if (hasImage) {
        try {
          String path = updatedProfileData.imagePath!;
          String fileName = path.split('/').last;
          String fileExtension = fileName.split('.').last.toLowerCase();
          String mimeType = getMimeTypeFromExtension(fileExtension);

          List<int> fileBytes = await File(path).readAsBytes();

          file = MultipartFile.fromBytes(
            fileBytes,
            filename: fileName,
            contentType: MediaType.parse(mimeType),
          );
        } catch (imageError) {
          debugPrint("Profile update with image - FAILED: $imageError");
          debugPrint("Falling back to text-only update...");
        }
      }

      final isMultipart = file != null;
      final data = {
        "email": updatedProfileData.email,
        "fullName": updatedProfileData.fullName,
        "address": updatedProfileData.address,
        if (updatedProfileData.phone.isNotEmpty)
          "phone": updatedProfileData.phone,
        if (file != null) "image": file,
        if (shouldRemoveImage) "removeImage": true,
      };

      await client.sendRequest(() => client.patch(
            Urls.me,
            payload: isMultipart ? FormData.fromMap(data) : data,
            headers: {
              'Content-Type':
                  isMultipart ? 'multipart/form-data' : 'application/json',
            },
          ));
    } catch (e, stackTrace) {
      debugPrint("Profile update - Error occurred: $e");
      debugPrint("Profile update - Stack trace: $stackTrace");
      rethrow;
    }
  }

  @override
  Future<void> sendResetPasswordMail({required String email}) {
    return client.sendRequest(
        () => client.post(Urls.forgotPassword, payload: <String, String>{
              "email": email,
            }));
  }

  @override
  Future<void> forgotPassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    return client.sendRequest(() => client.post(Urls.resetPassword,
            payload: <String, String>{
              "email": email,
              "otp": otp,
              "password": newPassword
            }));
  }
}
