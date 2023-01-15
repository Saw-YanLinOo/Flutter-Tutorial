import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/contant_bloc.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/add_moment_page.dart';
import 'package:wechat_redesign/pages/add_new_group_page.dart';
import 'package:wechat_redesign/pages/chat_detail_page.dart';
import 'package:wechat_redesign/pages/group_chat_detail_page.dart';
import 'package:wechat_redesign/pages/scan_qr_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';

class ContantPage extends StatelessWidget {
  const ContantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => ContantBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Contants',
            style: TextStyle(
              fontFamily: YorkieDEMO,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_BIG,
              color: PRIMARY_COLOR,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                navigateToScreen(context, const ScanQrPage());
              },
              child: Image.asset('assets/icons/add_contant.png'),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MARGIN_MEDIUM),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: PRIMARY_COLOR.withOpacity(0.3),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: PRIMARY_COLOR,
                    ),
                    suffixIcon: Icon(
                      Icons.clear,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: Text(
                'Group',
                style: TextStyle(
                  fontFamily: YorkieDEMO,
                  color: PRIMARY_COLOR,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Selector<ContantBloc, List<GroupVO>?>(
                selector: (p0, p1) => p1.groupList,
                builder: (c, groupList, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MARGIN_MEDIUM,
                        ),
                        GestureDetector(
                            onTap: () {
                              navigateToScreen(context, AddNewGroupPage());
                            },
                            child: Image.asset(
                                'assets/icons/add_group_contant.png')),
                        SizedBox(
                          width: MARGIN_MEDIUM,
                        ),
                        Container(
                          height: 100,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: groupList?.length ?? 0,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var group = groupList?[index];
                              return GestureDetector(
                                onTap: () {
                                  navigateToScreen(context,
                                      GroupChatDetailPage(group: group));
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(MARGIN_MEDIUM),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MARGIN_MEDIUM),
                                          ),
                                          child: Image.network(
                                            '${group?.groupPhoto}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MARGIN_MEDIUM,
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            '${group?.name}',
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: MARGIN_MEDIUM,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            Selector<ContantBloc, List<UserVO>?>(
              selector: (p0, p1) => p1.userList,
              builder: (context, userList, child) {
                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                    child: userList == null
                        ? Center(
                            child: Text("No Contant"),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              var user = userList[index];
                              return ListTile(
                                onTap: () {
                                  navigateToScreen(context,
                                      ChatDetailPage(reciverUser: user));
                                },
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    '${user.profilePhoto}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('${user.userName}'),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: MARGIN_SMALL,
                              );
                            },
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
