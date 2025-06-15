import 'package:dio/dio.dart';

import '../../../utils/app_exceptions/exceptions.dart';
import '../../../utils/urls.dart';

class ResponseHandler {
  static dynamic processResponse(dynamic response) {
    final dynamic decodedResponse = decodeResponse(response);
    switch (response.statusCode!) {
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

  static dynamic decodeResponse(Response response) {
    return response.data;
  }
}
