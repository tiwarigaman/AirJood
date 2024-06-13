import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../app_exception.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiAServices {
  @override
  Future getGetApiResponse(String url, String token) async {
    dynamic responseJson;
    var headers = {
      "Cookie": 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j',
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getSearchGetApiResponse(String url, String token) async {
    dynamic responseJson;
    var headers = {
      "Cookie": 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j',
      "Authorization": 'Bearer $token',
      'Accept': 'application/json',
    };
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url, String token) async {
    dynamic responseJson;
    var headers = {
      "Cookie": 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j',
      "Authorization": 'Bearer $token'
    };
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, Map<String, String> data) async {
    dynamic responseJson;
    try {
      var headers = {
        'Accept': 'application/json',
        'Cookie': 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j'
      };
      Response response = await http
          .post(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future profilePostApiResponse(
      String url, token, Map<String, String> data, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Cookie': 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j'
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('profile_image', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future reelPostApiResponse(String url, token, Map<String, String> data,
      dynamic video, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Cookie': 'airjood_session=ancIVzfTWIrBdNUhZRKCfnaEB6fjt4v4B4hJ55GS'
      };
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (video != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('video_path', video.path);
        request.files.add(multipartFile);
      }
      if (image != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'video_thumbnail_path', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future experiancePostApiResponse(
      String url, token, Map<String, String> data, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Cookie': 'airjood_session=ancIVzfTWIrBdNUhZRKCfnaEB6fjt4v4B4hJ55GS'
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'fridget_magnet_path', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future planningPostApiResponse(
      String url, token, Map<String, String> data, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Cookie': 'airjood_session=ancIVzfTWIrBdNUhZRKCfnaEB6fjt4v4B4hJ55GS'
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('plan_image', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future documentPostApiResponse(
      String url, token, image, image1, image2, image3) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Cookie': 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j'
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('any_id_path', image.path);
        request.files.add(multipartFile);
      }
      if (image1 != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('passport_path', image1.path);
        request.files.add(multipartFile);
      }
      if (image2 != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'tourist_certificate_path', image2.path);
        request.files.add(multipartFile);
      }
      if (image3 != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('tnc_path', image3.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future otpPostApiResponse(String url, Map<String, String> data) async {
    dynamic responseJson;
    try {
      var headers = {
        'Cookie': 'airjood_session=FsoQZmjEv7eb8NCI7qJGQ36YUlRZBur0to2hB46j'
      };
      Response response = await http
          .post(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(
      String url, String token, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }


  @override
  Future likePostApiResponse(
      String url, String token, Map<String, dynamic> data) async {
    dynamic responseJson;
    String jsonData = json.encode(data);
    try {
      Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Cookie':
                    'airjood_session=zYKJob7deGC4UNLXQ44wj75APD57ceqoLiSvfxir'
              },
              body: jsonData)
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future followPostApiResponse(String url, String token) async {
    dynamic responseJson;
    // String jsonData = json.encode(data);
    try {
      Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postMediaApiResponse(
      String url, String token, Map<String, String> data, File file) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Cookie': 'airjood_session=ancIVzfTWIrBdNUhZRKCfnaEB6fjt4v4B4hJ55GS'
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        // contentType: MediaType('audio', 'mpeg'),
      );
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print('Response =>${response.body}');
    }
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        Map<String, dynamic> errorJson = jsonDecode(response.body);
        String errorMessage = errorJson['message'];
        throw BadRequestException(errorMessage);
      case 404:
        Map<String, dynamic> errorJson = jsonDecode(response.body);
        String errorMessage = errorJson['message'];
        throw UnauthorisedException(errorMessage);
      default:
        Map<String, dynamic> errorJson = jsonDecode(response.body);
        String errorMessage = errorJson['message'];
        throw FetchDataException(
          /*'Error accorded while communicating with server' +
              'with status code\n' +*/
          //response.statusCode.toString(),
          errorMessage,
        );
    }
  }
}
