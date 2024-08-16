import 'package:airjood/data/response/api_response.dart';
import 'package:airjood/model/conversations_model.dart';
import 'package:airjood/model/invite_user_list_model.dart';
import 'package:airjood/model/messages_model.dart';
import 'package:airjood/model/pusher_conversation_model.dart';
import 'package:airjood/repository/chat_repository.dart';
import 'package:flutter/widgets.dart';
import '../utils/utils.dart';

class ChatViewModel extends ChangeNotifier {
  final myRepo = ChatRepository();
  bool _chatLoading = false;

  bool get chatLoading => _chatLoading;

  setLoading(bool val) {
    _chatLoading = val;
    notifyListeners();
  }

  List<ConversationsData> _conversationsData = [];

  List<ConversationsData> get conversationsData => _conversationsData;

  void setConversationsData(List data) {
    _conversationsData =
        data.map((item) => ConversationsData.fromJson(item)).toList();
    notifyListeners();
  }

  void addConversation(PusherConversationModel data) async {
    ConversationsData newConversation = ConversationsData(
      id: data.sender?.id,
      languages: data.sender?.languages,
      about: data.sender?.about,
      contactNo: data.sender?.contactNo,
      dob: data.sender?.dob,
      gender: data.sender?.gender,
      name: data.sender?.name,
      role: data.sender?.role,
      email: data.sender?.email,
      emailVerifiedAt: data.sender?.emailVerifiedAt,
      createdAt: data.sender?.createdAt,
      updatedAt: data.sender?.updatedAt,
      deletedAt: data.sender?.deletedAt,
      unreadCount: data.receiver?.unreadCount,
      lastMessage: LastMessage(
        id: data.message?.id,
        createdAt: data.message?.createdAt,
        createdBy: data.message?.createdBy,
        filePath: data.message?.filePath,
        message: data.message?.message,
        readAt: data.message?.readAt,
        toId: data.message?.toId,
        type: data.message?.type,
        updatedAt: data.message?.updatedAt,
      ),
      profileImageUrl: data.sender?.profileImageUrl,
      isUpgrade: data.sender?.isUpgrade,
      isFollowing: data.sender?.isFollowing,
      isFollower: data.sender?.isFollower,
      planInvitationStatus: data.sender?.planInvitationStatus,
    );
    int index = _conversationsData
        .indexWhere((conversation) => conversation.id == newConversation.id);
    if (index != -1) {
      _conversationsData[index] = newConversation;
    } else {
      _conversationsData.add(newConversation);
    }
    notifyListeners();
  }

  List<Message> _messagesData = [];

  List<Message> get messagesData => _messagesData;

  List<int> selectedMessageIds = [];

  void toggleSelection(int messageId) {
    if (selectedMessageIds.contains(messageId)) {
      selectedMessageIds.remove(messageId);
    } else {
      selectedMessageIds.add(messageId);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedMessageIds.clear();
    notifyListeners();
  }

  void deleteSelectedMessages() {
    messagesData
        .removeWhere((message) => selectedMessageIds.contains(message.id));
    clearSelection();
  }

  Metadata? _metadata;

  Metadata? get metadata => _metadata;

  void setMessagesData(List messages) {
    for (var item in messages) {
      Message message = Message.fromJson(item);
      _messagesData.add(message);
    }
    notifyListeners();
  }

  void setMetaData(dynamic data) {
    _metadata = Metadata.fromJson(data);
    notifyListeners();
  }

  void addMessage(PusherConversationModel data) async {
    Message newMessage = Message(
      id: data.message?.id,
      createdAt: data.message?.createdAt,
      createdBy: data.message?.createdBy,
      toId: data.message?.toId,
      message: data.message?.message,
      type: data.message?.type,
      filePath: data.message?.filePath,
      readAt: data.message?.readAt,
      updatedAt: data.message?.updatedAt,
      sender: data.sender,
      receiver: data.receiver,
    );
    int index =
        _messagesData.indexWhere((message) => message.id == newMessage.id);
    if (index != -1) {
      _messagesData[index] = newMessage;
    } else {
      _messagesData.insert(0, newMessage);
    }
    notifyListeners();
  }

  void clear() {
    _messagesData.clear();
    _metadata = null;
    notifyListeners();
  }

  Future<void> allMessagesApi(String token, String data) async {
    setLoading(true);
    await myRepo.allMessages(token, data).then((value) {
      setLoading(false);
      setMessagesData(value['data']['messages']);
      setMetaData(value['data']['metadata']);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  Future<void> messagesConversationsApi(String token) async {
    setLoading(true);
    myRepo.messagesConversations(token).then((value) {
      setLoading(false);
      setConversationsData(value['data']);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  Future<void> sendMessageApi(String token, Map<String, dynamic> data) async {
    setLoading(true);
    myRepo.sendMessage(token, data).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  Future<void> sendMediaApi(
      String token, Map<String, String> data, file) async {
    setLoading(true);
    await myRepo.sendMedia(token, data, file).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  Future<void> readAllApi(String token, String data) async {
    setLoading(true);
    myRepo.readAll(token, data).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  Future<void> deleteMessageApi(String token) async {
    setLoading(true);
    myRepo.deleteSelectedMessage(
        token, {"message_ids": selectedMessageIds}).then((value) {
      deleteSelectedMessages();
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage('$error');
    });
  }

  int _page = 1;
  List<Datum> usersList = [];

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }

  void clearData() {
    usersList.clear();
    notifyListeners();
  }

  ApiResponse<InviteUserListModel> userListData = ApiResponse.loading();

  setUserList(ApiResponse<InviteUserListModel> response) {
    userListData = response;
    response.data?.data?.forEach((element) {
      usersList.add(element);
    });
    notifyListeners();
  }

  Future<void> userListGetApi(String token, {String? search}) async {
    setUserList(ApiResponse.loading());
    try {
      final value = await myRepo.getUserList(token, _page, search: search);
      setUserList(ApiResponse.completed(value));
      _page++;
    } catch (error) {
      setUserList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
      rethrow;
    }
  }
}
