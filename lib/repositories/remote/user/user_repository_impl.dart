import 'package:http/src/response.dart';

import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/user.dart';
import '../../../utils/urls.dart';
import 'user_repository.dart';

class UserRepository implements IUserRepository {
  final NetworkManager client;
  UserRepository({required this.client});

  @override
  Future<String> login(
    String username,
    String password,
  ) async {
    final Response response = await client.sendRequest(
        () => client.post(Urls.auth, payload: <String, String>{"username": username, "password": password}));

    var decodedResponse = ResponseHandler.processResponse(response);

    return decodedResponse["token"];
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    final Response response = await client.sendRequest(() => client.get(Urls.me));

    var decodedResponse = ResponseHandler.processResponse(response);

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
