import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/blocs/chat_detail_bloc.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/view_items/chat_bubble_view_item.dart';
import 'package:path/path.dart' as p;

enum ChatAction {
  Text,
  File,
  Camera,
  Gif,
  Location,
  Voice,
}

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({
    Key? key,
    this.reciverUser,
  }) : super(key: key);

  final UserVO? reciverUser;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatDetailBloc(reciverUser?.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          leadingWidth: MARGIN_MEDIUM_3,
          title: Row(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          '${reciverUser?.profilePhoto}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${reciverUser?.userName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: TEXT_REGULAR_2X,
                        ),
                      ),
                      Text(
                        'Online',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PRIMARY_COLOR.withOpacity(0.8),
                          fontSize: TEXT_MEDIUM,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Icon(
              FontAwesomeIcons.ellipsisVertical,
            ),
          ],
        ),
        body: Column(
          children: [
            Selector<ChatDetailBloc, UserVO?>(
                selector: (p0, p1) => p1.currentUser,
                builder: (context, currentUser, child) {
                  return Selector<ChatDetailBloc, List<MessageVO>?>(
                      selector: (p0, p1) => p1.messageList,
                      shouldRebuild: (list1, list2) => true,
                      builder: (context, messages, child) {
                        return Expanded(
                          child: messages == null
                              ? Center(
                                  child: Text('no message'),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: messages.length,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: MARGIN_MEDIUM,
                                    vertical: MARGIN_MEDIUM,
                                  ),
                                  itemBuilder: (context, index) {
                                    var message = messages[index];
                                    var isMe =
                                        message.userId == '${currentUser?.id}';
                                    var nextIsMe = false;
                                    if (index == messages.length - 1) {
                                      nextIsMe = false;
                                    } else {
                                      nextIsMe = messages[index].userId ==
                                          '${messages[index == (messages.length - 1) ? index : index + 1].userId}';
                                    }

                                    return ChatBubbleItemView(
                                      isMe: isMe,
                                      nextIsMe: nextIsMe,
                                      message: message,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: MARGIN_SMALL,
                                    );
                                  },
                                ),
                        );
                      });
                }),
            Consumer<ChatDetailBloc>(builder: (context, bloc, child) {
              return Visibility(
                visible: bloc.activeAction == ChatAction.Text,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: bloc.message),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message',
                          ),
                          onChanged: bloc.onChangedMessage,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          bloc.sendMessage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: PRIMARY_COLOR,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(MARGIN_MEDIUM),
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            
            Consumer<ChatDetailBloc>(builder: (context, bloc, child) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 1, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, -2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ChatActionIcon(
                      action: ChatAction.Text,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {
                        bloc.setActiveAction(action);
                      },
                      icon: Icons.abc,
                    ),
                    ChatActionIcon(
                      action: ChatAction.File,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(allowMultiple: false);
                        if (result != null) {
                          debugPrint('${result.files.first.extension}');
                          bloc.setActiveAction(action);
                          bloc.setTempMessage('${result.files.first.extension}',
                              '${result.files.first.path}');
                        }
                      },
                      icon: Icons.image,
                    ),
                    ChatActionIcon(
                      action: ChatAction.Camera,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {
                        // if (action == bloc.activeAction) {
                        //   bloc.setActiveAction(null);
                        //   return;
                        // }

                        XFile? result = await ImagePicker().pickImage(
                            source: ImageSource.camera, imageQuality: 50);
                        if (result != null) {
                          debugPrint('${p.extension(result.path)}');
                          bloc.setActiveAction(action);
                          bloc.setTempMessage(
                              '${p.extension(result.path)}', '${result.path}');
                        }
                      },
                      icon: Icons.camera_alt,
                    ),
                    ChatActionIcon(
                      action: ChatAction.Gif,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {},
                      icon: Icons.gif_box,
                    ),
                    ChatActionIcon(
                      action: ChatAction.Location,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {},
                      icon: Icons.location_on,
                    ),
                    ChatActionIcon(
                      action: ChatAction.Voice,
                      activeAction: bloc.activeAction,
                      onTapIcon: (action) async {},
                      icon: Icons.keyboard_voice_outlined,
                    ),
                  ],
                ),
              );
            }),
            Consumer<ChatDetailBloc>(builder: (context, bloc, child) {
              return bloc.activeAction == ChatAction.Text
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              if (bloc.tempFileMessage?.messageType ==
                                  MessageType.video.name)
                                VideoView(url: bloc.tempFileMessage?.file),
                              if (bloc.tempFileMessage?.messageType ==
                                  MessageType.image.name)
                                ImageView(filePath: bloc.tempFileMessage?.file),
                              SizedBox(
                                height: MARGIN_MEDIUM,
                              ),
                            ],
                          ),
                          bloc.isLoading
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    bloc.sendMessage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: PRIMARY_COLOR,
                                      shape: BoxShape.circle,
                                    ),
                                    padding:
                                        const EdgeInsets.all(MARGIN_MEDIUM),
                                    child: Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}

class VideoView extends StatefulWidget {
  const VideoView({
    Key? key,
    this.url,
  }) : super(key: key);

  final String? url;
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.file(File("${widget.url}")),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    this.filePath,
  }) : super(key: key);

  final String? filePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.file(
        File('${filePath}'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class ChatActionIcon extends StatelessWidget {
  const ChatActionIcon({
    Key? key,
    required this.icon,
    required this.action,
    this.activeAction,
    required this.onTapIcon,
  }) : super(key: key);

  final IconData icon;
  final ChatAction action;
  final ChatAction? activeAction;
  final Function(ChatAction) onTapIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapIcon(action);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            elevation: MARGIN_MEDIUM,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: action == activeAction ? PRIMARY_COLOR : Colors.white,
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              ),
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: Icon(
                icon,
                color: action == activeAction ? Colors.white : PRIMARY_COLOR,
              ),
            ),
          ),
          // Visibility(
          //   visible: action == activeAction,
          //   child: Positioned(
          //     right: -MARGIN_MEDIUM,
          //     top: -MARGIN_MEDIUM,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.red,
          //         shape: BoxShape.circle,
          //       ),
          //       child: Icon(
          //         Icons.clear,
          //         size: MARGIN_MEDIUM_2,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
