import 'package:dio/dio.dart';
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
      {required EditProfileFormDataModel updatedProfileData}) async {
    Map<String, dynamic> dataAsMap = updatedProfileData.toJson();
    dataAsMap.removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
    FormData formData = FormData.fromMap(
      {
        ...dataAsMap,
        "removeImage": true,
        if (updatedProfileData.imagePath != null)
          'image': await MultipartFile.fromFile(updatedProfileData.imagePath!,
              filename: updatedProfileData.imagePath!.split('/').last),
      },
      ListFormat.multiCompatible,
    );

    await client.sendRequest(() => client.patch(Urls.me, payload: formData));
  }

  @override
  Future<void> sendResetPasswordMail({required String email}) {
    return client.sendRequest(
        () => client.post(Urls.forgotPassword, payload: <String, String>{
              "email": email,
            }));
  }
}
