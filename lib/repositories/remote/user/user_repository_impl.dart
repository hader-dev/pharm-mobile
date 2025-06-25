import 'package:dio/dio.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:http_parser/http_parser.dart';

import '../../../config/services/network/network_response_handler.dart';
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
    var decodedResponse = await client
        .sendRequest(() => client.post(Urls.logIn, payload: <String, String>{"email": username, "password": password}));

    return decodedResponse["accessToken"];
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    var decodedResponse = await client.sendRequest(() => client.get(Urls.me));

    return UserModel.fromJson(decodedResponse);
  }

  @override
  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    final Response response =
        await client.sendRequest(() => client.patch("${Urls.client}/me", payload: <String, Map<String, String>>{
              "user": <String, String>{"oldPassword": oldPassword, "newPassword": newPassword}
            }));

    var decodedResponse = ResponseHandler.processResponse(response);

    if (!decodedResponse["success"]) throw "Failed to change password";
  }

  @override
  Future<String> emailSignUp(String email, String fullName, String password, {String? userImagePath}) async {
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
  Future<String> checkUserEmail({required String email, required String otp}) async {
    var decodedResponse = await client
        .sendRequest(() => client.post(Urls.verifyEmail, payload: <String, String>{"email": email, "otp": otp}));

    return decodedResponse["accessToken"];
  }

  @override
  Future<void> resendOtp({required String email}) async {
    var decodedResponse = await client.sendRequest(() => client.post(Urls.resendOtp, payload: <String, String>{
          "email": email,
        }));

    return decodedResponse["accessToken"];
  }

  @override
  Future<void> sendResetPasswordMail({required String email}) {
    return client.sendRequest(() => client.post(Urls.forgotPassword, payload: <String, String>{
          "email": email,
        }));
  }

  // @override
  // Future<void> changePassword({
  //   required String oldPassword,
  //   required String newPassword,
  // }) async {
  //   var uri = Uri.parse(Urls.me);

  //   final response = await http.put(
  //     uri,
  //     headers: _headers,
  //     body: jsonEncode({
  //       "user": {
  //         'oldPassword': oldPassword,
  //         'newPassword': newPassword,
  //       }
  //     }),
  //   );

  //   ResponseHandler.processResponse(response);
  // }
}
