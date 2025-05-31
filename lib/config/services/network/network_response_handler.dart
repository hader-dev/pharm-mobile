import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/app_exceptions/exceptions.dart';

class ResponseHandler {
  static dynamic processResponse(http.Response response) {
    final dynamic decodedResponse = decodeResponseBody(response);
    print("Response: ${response.body}");
    switch (response.statusCode) {
      case >= 200 && < 300:
        return decodedResponse;
      case 400: //Bad request
        throw BadRequestException.fromJson(decodedResponse);
      case 401: //Unauthorized
        throw UnAuthenticatedException.fromJson(decodedResponse);
      case 403: //Forbidden
        throw UnAuthorizedException.fromJson(decodedResponse);
      case 404: //Resource Not Found
        throw NotFoundException.fromJson(decodedResponse);

      case 500: //Internal Server Error
        throw InternalServerErrorException.fromJson(decodedResponse);
      default:
        throw FetchDataException.fromJson(decodedResponse);
    }
  }

  static dynamic decodeResponseBody(http.Response response) {
    return jsonDecode(response.body.isEmpty ? jsonEncode("done") : response.body);
  }
}
