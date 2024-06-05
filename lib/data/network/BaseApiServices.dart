import 'dart:io';

abstract class BaseApiAServices {
  Future<dynamic> getGetApiResponse(String url, String token);
  Future<dynamic> getSearchGetApiResponse(String url, String token);
  Future<dynamic> getDeleteApiResponse(String url, String token);
  Future<dynamic> getApiResponse(String url);

  Future<dynamic> getPostApiResponse(
    String url,
    Map<String, String> data,
  );

  Future<dynamic> otpPostApiResponse(
    String url,
    Map<String, String> data,
  );

  Future<dynamic> profilePostApiResponse(
    String url,
    dynamic token,
    Map<String, String> data,
    dynamic image,
  );
  Future<dynamic> reelPostApiResponse(
    String url,
    String token,
    Map<String, String> data,
    File video,
    File image,
  );
  Future<dynamic> experiancePostApiResponse(
    String url,
    String token,
    Map<String, String> data,
    File image,
  );
  Future<dynamic> planningPostApiResponse(
      String url,
      String token,
      Map<String, String> data,
      File image,
      );

  Future<dynamic> documentPostApiResponse(
    String url,
    String? token,
    File? image,
    File? image1,
    File? image2,
    File? image3,
  );

  Future<dynamic> postApiResponse(
    String url,
    String token,
    Map<String, dynamic> data,
  );
  Future<dynamic> likePostApiResponse(
    String url,
    String token,
    Map<String, dynamic> data,
  );
  Future<dynamic> followPostApiResponse(
    String url,
    String token,
  );
}
