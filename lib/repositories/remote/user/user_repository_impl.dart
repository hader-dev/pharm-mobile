import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/user/mappers/json_to_user.dart';

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
      file = await MultipartFile.fromFile(
        userImagePath,
        filename: fileName,
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
    var decodedResponse = await client.sendRequest(
        () => client.post(Urls.resendOtp, payload: <String, String>{
              "email": email,
            }));

    return decodedResponse["accessToken"];
  }

  @override
  Future<void> updateProfile(
      {required EditProfileFormDataModel updatedProfileData,
      bool shouldRemoveImage = false}) async {
    try {
      final imagePath = updatedProfileData.imagePath;
      Uint8List? imageBytes;

// Read image file as bytes if imagePath is provided
      if (imagePath != null && imagePath.isNotEmpty) {
        final file = File(imagePath);
        if (await file.exists()) {
          imageBytes = await file.readAsBytes();
        }
      }

// Create payload with profile data and image bytes
      Map<String, dynamic> payload = {
        'email': updatedProfileData.email,
        'fullName': updatedProfileData.fullName,
        'phone': updatedProfileData.phone,
        if (imageBytes != null) 'image': base64Encode(imageBytes),
      };

// Use PATCH with JSON content type
      var response = await client.sendRequest(() => client.patch(
            Urls.me,
            payload: payload,
            headers: {'Content-Type': 'application/json'},
          ));

      debugPrint("Profile update - Success response: $response");
    } catch (e, stackTrace) {
      debugPrint("Profile update - Error occurred: $e");
      debugPrint("Profile update - Error type: ${e.runtimeType}");
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
}
