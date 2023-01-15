import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/chat_bloc.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/chat_detail_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_3, vertical: MARGIN_MEDIUM),
              child: AppBarSection(onTapSearch: () {}),
            ),
            SizedBox(
              height: MARGIN_CARD_MEDIUM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
              child: Text('Active Now'),
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            Selector<ChatBloc, List<UserVO>?>(
                selector: (p0, p1) => p1.userList,
                builder: (context, userList, child) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: userList?.length ?? 0,
                      itemBuilder: (context, index) {
                        var user = userList?[index];
                        return SizedBox(
                          width: 80,
                          height: 80,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      '${user?.profilePhoto}',
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
                                height: MARGIN_MEDIUM,
                              ),
                              Text(
                                '${user?.userName}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PRIMARY_COLOR,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Selector<ChatBloc, List<UserVO>?>(
                selector: (p0, p1) => p1.userList,
                builder: (context, userList, child) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userList?.length ?? 0,
                      padding:
                          const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                      itemBuilder: (context, index) {
                        var user = userList?[index];
                        return InkWell(
                          onTap: () {
                            navigateToScreen(
                                context, ChatDetailPage(reciverUser: user));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(MARGIN_MEDIUM),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              '${user?.profilePhoto}',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${user?.userName}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: PRIMARY_COLOR,
                                              fontSize: TEXT_REGULAR_2X,
                                            ),
                                          ),
                                          Text(
                                            '...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '5 min',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: MARGIN_CARD_MEDIUM_2,
                                      ),
                                      Icon(
                                        Icons.done_all,
                                        size: TEXT_REGULAR_2X,
                                        color: Colors.greenAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    Key? key,
    required this.onTapSearch,
  }) : super(key: key);

  final Function onTapSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Chats',
          style: TextStyle(
            fontFamily: YorkieDEMO,
            fontWeight: FontWeight.w600,
            fontSize: TEXT_BIG,
            color: PRIMARY_COLOR,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(MARGIN_MEDIUM),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
