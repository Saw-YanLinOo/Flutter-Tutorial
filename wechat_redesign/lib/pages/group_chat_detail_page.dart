import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/chat_detail_bloc.dart';
import 'package:wechat_redesign/blocs/group_chat_detail_bloc.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/chat_detail_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/view_items/chat_bubble_view_item.dart';
import 'package:path/path.dart' as p;

class GroupChatDetailPage extends StatelessWidget {
  const GroupChatDetailPage({
    Key? key,
    this.group,
  }) : super(key: key);

  final GroupVO? group;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupChatDetailBloc(group?.id),
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
                          '${group?.groupPhoto}',
                          fit: BoxFit.fill,
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
                        '${group?.name}',
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
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Selector<GroupChatDetailBloc, UserVO?>(
                selector: (p0, p1) => p1.currentUser,
                builder: (context, currentUser, child) {
                  return Selector<GroupChatDetailBloc, List<MessageVO>?>(
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
                                      horizontal: MARGIN_MEDIUM),
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
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Consumer<GroupChatDetailBloc>(builder: (context, bloc, child) {
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
            Consumer<GroupChatDetailBloc>(builder: (context, bloc, child) {
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
            Consumer<GroupChatDetailBloc>(builder: (context, bloc, child) {
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
