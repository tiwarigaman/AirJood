import 'dart:io';

import 'package:airjood/data/network/BaseApiServices.dart';
import 'package:airjood/data/network/NetworkApiServices.dart';
import 'package:airjood/res/app_url.dart';

import '../model/invite_user_list_model.dart';

class ChatRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> allMessages(String token, String data) async {
    try {
      dynamic response =
          await apiAServices.getGetApiResponse(AppUrl.messages + data, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> messagesConversations(
    String token,
  ) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          AppUrl.messagesConversations, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sendMessage(
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      dynamic response =
          await apiAServices.postApiResponse(AppUrl.messages, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sendMedia(
    String token,
    Map<String, String> data,
    File file,
  ) async {
    try {
      dynamic response = await apiAServices.postMediaApiResponse(
          AppUrl.messages, token, data, file);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> readAll(String token, String data) async {
    try {
      dynamic response = await apiAServices
          .postApiResponse(AppUrl.messagesReadAll + data, token, {});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteMessage(String token, String data) async {
    try {
      dynamic response = await apiAServices.getDeleteApiResponse(
          AppUrl.messages + data, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteSelectedMessage(
      String token, Map<String, dynamic> data) async {
    try {
      dynamic response =
          await apiAServices.deleteApiResponse(AppUrl.messages, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<InviteUserListModel> getUserList(String token, int page,
      {String? search}) async {
    try {
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.getInviteUserList}?search=$search", token);
      return response = InviteUserListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
