import 'dart:async';
import 'dart:io';
import 'package:airjood/model/messages_model.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/chat_view/chat_components/audio_box.dart';
import 'package:airjood/view/navigation_view/chat_view/chat_components/image_box.dart';
import 'package:airjood/view/navigation_view/chat_view/chat_components/text_box.dart';
import 'package:airjood/view/navigation_view/chat_view/chat_components/video_box.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import 'package:airjood/model/conversations_model.dart';
import 'package:airjood/model/pusher_conversation_model.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view_model/chat_view_model.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../utils/pusher_service.dart';

class ChatDetailsScreen extends StatefulWidget {
  final ConversationsData user;

  const ChatDetailsScreen({super.key, required this.user});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final unfocusNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  int offset = 0;
  int limit = 20;
  bool isLoading = false;
  bool _showEmojiPicker = false;
  late PusherService pusherService;
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String _recordFilePath = '';
  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;
  double _micButtonScale = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ChatViewModel>(context, listen: false).clear();
      await fetchData();
      initPusher();
      readMessage();
      _focusNode.requestFocus();
    });
  }

  Future<void> initPusher() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    final user = await UserViewModel().getUser();
    pusherService = PusherService();
    pusherService.bind('chat_${user?.id}_${widget.user.id}', (data) {
      try {
        PusherConversationModel pusherConversationModel =
            pusherConversationModelFromJson(data.data);
        if (pusherConversationModel.message != null) {
          chatProvider.addMessage(pusherConversationModel);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if (kDebugMode) {
        print('New message received: $data');
      }
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
      final token = await UserViewModel().getToken();
      await chatProvider.allMessagesApi(
          token!, '?receiver_id=${widget.user.id}&offset=$offset&limit=$limit');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void loadMoreMessages() {
    fetchData(); // Fetch the next set of messages
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      setState(() {
        offset += limit;
      });
      fetchData();
    }
  }

  Future<void> readMessage() async {
    UserViewModel().getToken().then((value) async {
      final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
      await chatProvider.readAllApi(value!, '?receiver_id=${widget.user.id}');
    });
  }

  Future<void> sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      UserViewModel().getToken().then((value) async {
        final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
        await chatProvider.sendMessageApi(value!, {
          'message': _messageController.text.trim(),
          'receiver_id': '${widget.user.id}',
          'type': 'text',
          // 'file': ''
        });
        _messageController.clear();
      });
    }
  }

  Future<void> deleteMessage() async {
    UserViewModel().getToken().then((value) async {
      final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
      await chatProvider.deleteMessageApi(value!);
    });
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete the selected messages?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deleteMessage(); // Call deleteMessage with the message ID
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _startRecording() async {
    await _audioRecorder.hasPermission();
    setState(() {
      _micButtonScale = 1.1; // Scale up when starting recording
    });
    if (await _audioRecorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacHe),
        path: filePath,
      );

      setState(() {
        _isRecording = true;
        _recordFilePath = filePath;
        _recordingDuration = Duration.zero;
      });

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingDuration =
              Duration(seconds: _recordingDuration.inSeconds + 1);
        });
      });
    }
  }

  Future<void> _stopRecording() async {
    setState(() {
      _micButtonScale = 1.0; // Reset scale when stopping recording
    });
    final path = await _audioRecorder.stop();

    if (path != null) {
      setState(() {
        _isRecording = false;
        _recordingTimer?.cancel();
        _recordingDuration = Duration.zero;
      });
      _sendRecordedAudio(File(path));
    }
  }

  Future<void> _sendRecordedAudio(File file) async {
    if (kDebugMode) {
      print('Sending recorded audio file: ${file.path}');
    }
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    final token = await UserViewModel().getToken();
    await chatProvider.sendMediaApi(
      token ?? '',
      {'message': '', 'receiver_id': '${widget.user.id}', 'type': 'audio'},
      file,
    );
  }

  Widget _buildMessageWidget(Message message) {
    switch (message.type) {
      case 'audio':
        return AudioBox(
          audioUrl: message.filePath,
          num: message.receiver?.id == widget.user.id ? 0 : 1,
        );
      case 'video':
        return VideoBox(
          videoUrl: message.filePath ?? '',
          num: message.receiver?.id == widget.user.id ? 0 : 1,
        );
      case 'image':
        return ImageBox(
          data: message.filePath ?? '',
          num: message.receiver?.id == widget.user.id ? 0 : 1,
        );
      default:
        return TextBox(
          data: message.message ?? '',
          num: message.receiver?.id == widget.user.id ? 0 : 1,
        );
    }
  }

  @override
  void dispose() {
    pusherService.unbind();
    _audioRecorder.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context);
    final padding = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          actions: [
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 35,
                weight: 2,
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.user.profileImageUrl ?? ''),
            ),
            const SizedBox(width: 15),
            CustomText(
              data: widget.user.name ?? '',
              fSize: 20,
              fweight: FontWeight.w700,
              fontColor: AppColors.blackColor,
            ),
            const Spacer(),
            if (chatProvider.selectedMessageIds.isNotEmpty) ...[
              TextButton(
                onPressed: () => chatProvider.clearSelection(),
                child: const Text('Cancel'),
              )
            ] else ...[
              const Icon(CupertinoIcons.ellipsis_vertical),
              const SizedBox(width: 15),
            ]
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  Consumer<ChatViewModel>(builder: (context, provider, child) {
                return Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: provider.messagesData.length,
                      itemBuilder: (context, index) {
                        final message = provider.messagesData[index];
                        final isSelected =
                            provider.selectedMessageIds.contains(message.id);

                        return GestureDetector(
                          onTap: () {
                            if (provider.selectedMessageIds.isNotEmpty &&
                                message.receiver?.id == widget.user.id) {
                              provider.toggleSelection(message.id ?? 0);
                            }
                          },
                          onLongPress: () {
                            if (message.receiver?.id == widget.user.id) {
                              provider.toggleSelection(message.id ?? 0);
                            }
                          },
                          child: Container(
                            color: isSelected
                                ? Colors.grey[300]
                                : Colors.transparent,
                            child: _buildMessageWidget(message),
                          ),
                        );
                      },
                    ),
                    if (isLoading)
                      Positioned(
                        top: 10,
                        left: MediaQuery.of(context).size.width / 2 - 15,
                        child: const CircularProgressIndicator(),
                      ),
                  ],
                );
              }),
            ),
            if (chatProvider.selectedMessageIds.isNotEmpty)
              Container(
                color: AppColors.textFildBGColor,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 12 + padding.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _showDeleteConfirmationDialog(context),
                      icon: const Icon(Icons.delete),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                          '${chatProvider.selectedMessageIds.length} selected'),
                    ),
                  ],
                ),
              )
            else
              Container(
                color: AppColors.textFildBGColor,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10 + padding.bottom),
                child: Column(
                  children: [
                    if (_isRecording)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Recording... ${_recordingDuration.inSeconds}s',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(CupertinoIcons.photo_on_rectangle),
                          color: AppColors.textFildHintColor,
                          onPressed: () {
                            _showImagePickerBottomSheet(context);
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _audioRecorder.hasPermission();
                          },
                          onLongPressStart: (details) => _startRecording(),
                          onLongPressEnd: (details) => _stopRecording(),
                          child: Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: _isRecording
                                ? const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  )
                                : null,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: _isRecording
                                  ? Icon(Icons.mic,
                                      key: UniqueKey(), color: Colors.white)
                                  : Icon(Icons.mic_none,
                                      key: UniqueKey(), color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: MainTextFild(
                            controller: _messageController,
                            focusNode: _focusNode,
                            hintText: 'Type Message...',
                            minLines: 1,
                            maxLines: 3,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.sentiment_neutral_sharp),
                              color: AppColors.textFildHintColor,
                              onPressed: () {
                                if (_showEmojiPicker) {
                                  _showEmojiPicker = false;
                                  FocusScope.of(context).requestFocus();
                                } else {
                                  FocusScope.of(context).unfocus();
                                  _showEmojiPicker = true;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => sendMessage(),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !_showEmojiPicker,
                      child: EmojiPicker(
                        textEditingController: _messageController,
                        // scrollController: _scrollController,
                        config: const Config(
                          height: 256,
                          checkPlatformCompatibility: true,
                          emojiViewConfig: EmojiViewConfig(),
                          swapCategoryAndBottomBar: false,
                          skinToneConfig: SkinToneConfig(),
                          categoryViewConfig: CategoryViewConfig(),
                          bottomActionBarConfig:
                              BottomActionBarConfig(enabled: false),
                          searchViewConfig: SearchViewConfig(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<File?> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> sendMedia(File file, String type) async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    final token = await UserViewModel().getToken();
    await chatProvider.sendMediaApi(
      token ?? '',
      {'message': '', 'receiver_id': '${widget.user.id}', 'type': type},
      file,
    );
  }

  Future<File?> _getVideoFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> _convertMovToMp4(File inputFile) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String outputPath = p.join(
          tempDir.path, '${p.basenameWithoutExtension(inputFile.path)}.mp4');

      // Add '-y' to force overwrite
      final String command =
          '-y -i ${inputFile.path} -vcodec h264 -acodec aac $outputPath';

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      // Capture FFmpeg logs
      final logs = await session.getLogs();
      final statistics = await session.getStatistics();

      for (var log in logs) {
        if (kDebugMode) {
          print('FFmpeg log: ${log.getMessage()}');
        }
      }

      if (kDebugMode) {
        print('FFmpeg statistics: $statistics');
      }

      if (ReturnCode.isSuccess(returnCode)) {
        if (kDebugMode) {
          print("Converted file path: $outputPath");
        }
        return File(outputPath);
      } else {
        if (kDebugMode) {
          print("FFmpeg conversion failed with return code: $returnCode");
        }
        for (var log in logs) {
          if (kDebugMode) {
            print('FFmpeg log: ${log.getMessage()}');
          }
        }
        if (kDebugMode) {
          print('FFmpeg statistics: $statistics');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during video conversion: $e");
      }
    }
    return null;
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(CupertinoIcons.camera_on_rectangle_fill,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Camera',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final file = await _getImageFromCamera();
                    if (file != null) await sendMedia(file, 'image');
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
                      CupertinoIcons.photo_fill_on_rectangle_fill,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final file = await _getImageFromGallery();
                    if (file != null) await sendMedia(file, 'image');
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(CupertinoIcons.video_camera_solid,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Video',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      final file = await _getVideoFromGallery();
                      if (file != null) {
                        final convertedFile = await _convertMovToMp4(file);
                        if (convertedFile != null) {
                          await sendMedia(convertedFile, 'video');
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print('Video error $e');
                      }
                      Utils.toastMessage('Something went wrong!');
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
