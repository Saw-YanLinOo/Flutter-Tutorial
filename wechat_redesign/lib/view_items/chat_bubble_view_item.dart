import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_redesign/blocs/chat_detail_bloc.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/pages/chat_detail_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class ChatBubbleItemView extends StatelessWidget {
  const ChatBubbleItemView({
    Key? key,
    required this.isMe,
    required this.nextIsMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final bool nextIsMe;
  final MessageVO message;

  @override
  Widget build(BuildContext context) {
    double messageBubbleWidth = 0;
    int messageLength = message.message?.length ?? 0;
    if (messageLength <= 10) {
      messageBubbleWidth = 0.3;
    } else if (messageLength >= 10 && messageLength < 20) {
      messageBubbleWidth = 0.5;
    } else {
      messageBubbleWidth = 0.7;
    }

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isMe && !nextIsMe
                ? Stack(
                    children: [
                      Container(
                        height: MARGIN_LARGE_2,
                        width: MARGIN_LARGE_2,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: message.profilePhoto == null ||
                                message.profilePhoto == ''
                            ? Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.grey.shade300,
                              )
                            : Image.network(
                                message.profilePhoto ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: MARGIN_LARGE_2,
                    width: MARGIN_LARGE_2,
                  ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            //if (message.messageType == MessageType.text.name)

            (message.message == MessageType.image.name)
                ? ChatBubbleImageView(isMe: isMe, message: message)
                : (message.message == MessageType.video.name)
                    ? ChatBubbleVideoView(isMe: isMe, message: message)
                    : ChatBubbleTextView(
                        messageBubbleWidth: messageBubbleWidth,
                        isMe: isMe,
                        message: message),
          ],
        )
      ],
    );
  }
}

class ChatBubbleVideoView extends StatelessWidget {
  const ChatBubbleVideoView({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final MessageVO message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width / 1.8,
          height: 180,
          decoration: BoxDecoration(
            color: isMe ? PRIMARY_COLOR : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          ),
          child: VideoPlayerView(
            url: '${message.file}',
            // fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${DateFormat('hh:mm a').format(DateTime.parse('${message.timeStamp}'))}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 5),
            if (isMe)
              const Icon(
                Icons.done_all,
                size: 20,
                color: Colors.green,
              )
          ],
        ),
      ],
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    Key? key,
    this.url,
  }) : super(key: key);

  final String? url;
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.network("${widget.url}"),
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

class ChatBubbleImageView extends StatelessWidget {
  const ChatBubbleImageView({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final MessageVO message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width / 1.8,
          height: 180,
          decoration: BoxDecoration(
            color: isMe ? PRIMARY_COLOR : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          ),
          child: Image.network(
            '${message.file}',
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${DateFormat('hh:mm a').format(DateTime.parse('${message.timeStamp}'))}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 5),
            if (isMe)
              const Icon(
                Icons.done_all,
                size: 20,
                color: Colors.green,
              )
          ],
        ),
      ],
    );
  }
}

class ChatBubbleTextView extends StatelessWidget {
  const ChatBubbleTextView({
    Key? key,
    required this.messageBubbleWidth,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final double messageBubbleWidth;
  final bool isMe;
  final MessageVO message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * messageBubbleWidth),
      decoration: BoxDecoration(
        color: isMe ? PRIMARY_COLOR : Colors.grey.withOpacity(0.2),
        borderRadius:
            BorderRadius.circular(MARGIN_MEDIUM_2 * messageBubbleWidth),
      ),
      padding: const EdgeInsets.all(MARGIN_MEDIUM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${message.message}',
            style: TextStyle(
              color: isMe ? Colors.white : PRIMARY_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${DateFormat('hh:mm a').format(DateTime.parse('${message.timeStamp}'))}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
              if (isMe)
                const Icon(
                  Icons.done_all,
                  size: 20,
                  color: Colors.green,
                )
            ],
          ),
        ],
      ),
    );
  }
}
