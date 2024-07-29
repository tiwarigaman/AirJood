import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddCommunityCommentRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addCommunityCommentApi(dynamic token, Map<String, String> data,
      {File? attachment}) async {
    try {
      dynamic response =
      await apiAServices.communityCommentPostApiResponse(AppUrl.addCommunityComment, token, data,attachment: attachment);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
