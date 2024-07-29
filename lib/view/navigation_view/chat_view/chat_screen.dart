import 'package:airjood/model/conversations_model.dart';
import 'package:airjood/model/pusher_conversation_model.dart';
import 'package:airjood/model/user_model.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:airjood/view/navigation_view/chat_view/chat_details_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/user_details_screen.dart';
import 'package:airjood/view_model/chat_view_model.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/maintextfild.dart';
import '../../../utils/pusher_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String? token;
  User? user;
  late PusherService pusherService;

  @override
  void initState() {
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
    fetchData();
    initPusher();
    super.initState();
  }

  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      token = value;
      final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
      await chatProvider.messagesConversationsApi(value!);
    });
  }

  Future<void> initPusher() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    user = await UserViewModel().getUser();
    setState(() {});
    pusherService = PusherService();
    pusherService.bind('conversation_${user?.id}', (data) {
      try {
        PusherConversationModel pusherConversationModel =
            pusherConversationModelFromJson(data.data);
        if (pusherConversationModel.message != null) {
          chatProvider.addConversation(pusherConversationModel);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  @override
  void dispose() {
    pusherService.unbind();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  String? image;
  String? images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 20,
          ),
          const CustomText(
            data: 'My Chats',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDetailsScreen(
                    screen: 'MyScreen',
                  ),
                ),
              ).then((value) {
                UserViewModel().getUser().then((value) {
                  images = value?.profileImageUrl;
                  // widget.getImage!(value?.profileImageUrl);
                  setState(() {});
                });
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: image ?? 'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
                errorWidget: (context, url, error) {
                  return Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(100),
                      color: AppColors.blueShade,
                    ),
                    child: const Icon(
                      CupertinoIcons.person,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Consumer<ChatViewModel>(builder: (context, provider, child) {
        provider.conversationsData.sort((a, b) {
          final aDate = a.lastMessage?.createdAt ?? DateTime.now();
          final bDate = b.lastMessage?.createdAt ?? DateTime.now();
          return bDate.compareTo(aDate); // Sort in descending order
        });
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainTextFild(
                  controller: _searchController,
                  hintText: 'Search People...',
                  maxLines: 1,
                  onChanged: (values) {
                    if (values.length == 3 || values.isEmpty) {
                      Provider.of<ChatViewModel>(context, listen: false)
                          .setPage(1);
                      Provider.of<ChatViewModel>(context, listen: false)
                          .clearData();
                      Provider.of<ChatViewModel>(context, listen: false)
                          .userListGetApi(token!, search: values);
                    }
                  },
                  onFieldSubmitted: (values) {
                    Provider.of<ChatViewModel>(context, listen: false)
                        .setPage(1);
                    Provider.of<ChatViewModel>(context, listen: false)
                        .clearData();
                    Provider.of<ChatViewModel>(context, listen: false)
                        .userListGetApi(token!, search: values);
                  },
                  prefixIcon: const Icon(
                    Icons.search_sharp,
                    color: AppColors.textFildHintColor,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: const Icon(Icons.close),
                          color: AppColors.textFildHintColor,
                        )
                      : null,
                ),
                const SizedBox(
                  height: 15,
                ),
                if (_searchController.text.trim().isNotEmpty) ...[
                  ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.usersList.length,
                    itemBuilder: (context, index) {
                      final user = provider.usersList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatDetailsScreen(
                                  user: ConversationsData(
                                    id: user.id,
                                    languages: user.languages,
                                    about: user.about,
                                    contactNo: user.contactNo,
                                    dob: user.dob,
                                    gender: user.gender,
                                    name: user.name,
                                    role: user.role,
                                    email: user.email,
                                    profileImageUrl: user.profileImageUrl,
                                  ),
                                ),
                              ),
                            ).then((value) {
                              fetchData();
                              initPusher();
                            });
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      provider.usersList[index].profileImageUrl ?? 'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: AppColors.blueShade,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.person,
                                      ),
                                    );
                                  },
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    data: provider.usersList[index].name ??
                                        'Saimon Jhonson',
                                    fSize: 15,
                                    color: AppColors.blackTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    data: provider.usersList[index].email ??
                                        'davidwarner21@gmail.com',
                                    fSize: 13,
                                    color: AppColors.secondTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  if (provider.chatLoading)
                    const FollowersShimmer()
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.conversationsData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final user = provider.conversationsData[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatDetailsScreen(user: user),
                              ),
                            ).then((value) {
                              fetchData();
                              initPusher();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    user.profileImageUrl ?? 'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          color: AppColors.blueShade,
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.person,
                                        ),
                                      );
                                    },
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        data: user.name ?? '',
                                        fSize: 15,
                                        color: AppColors.blackTextColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Row(
                                        children: [
                                          if (user.lastMessage?.type == 'image')
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(Icons.image,
                                                  size: 14,
                                                  color: AppColors
                                                      .secondTextColor),
                                            ),
                                          if (user.lastMessage?.type == 'video')
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(
                                                  Icons.video_camera_back,
                                                  size: 14,
                                                  color: AppColors
                                                      .secondTextColor),
                                            ),
                                          if (user.lastMessage?.type == 'audio')
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              child: Icon(Icons.mic,
                                                  size: 14,
                                                  color: AppColors
                                                      .secondTextColor),
                                            ),
                                          Expanded(
                                            child: CustomText(
                                              data: user.lastMessage?.type ==
                                                      'image'
                                                  ? 'Image'
                                                  : user.lastMessage?.type ==
                                                          'video'
                                                      ? 'video'
                                                      : user.lastMessage
                                                                  ?.type ==
                                                              'audio'
                                                          ? 'audio'
                                                          : user.lastMessage
                                                                  ?.message ??
                                                              '',
                                              fSize: 13,
                                              color:
                                                  AppColors.secondTextColor,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if ((user.unreadCount ?? 0) > 0)
                                      CircleAvatar(
                                        backgroundColor: AppColors.mainColor,
                                        radius: 10,
                                        child: Center(
                                          child: CustomText(
                                            data: '${user.unreadCount}',
                                            color: AppColors.whiteTextColor,
                                            fSize: 10,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 5),
                                    CustomText(
                                      data: timeago.format(
                                          user.lastMessage?.createdAt ??
                                              DateTime.now()),
                                      color: AppColors.secondTextColor,
                                      fontWeight: FontWeight.w500,
                                      fSize: 13,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 100),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
