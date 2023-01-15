import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/add_new_group_bloc.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';
import 'package:wechat_redesign/widgets/loading_view.dart';

class AddNewGroupPage extends StatelessWidget {
  const AddNewGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewGroupBloc(),
      child: Selector<AddNewGroupBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) {
            return Stack(
              children: [
                SafeArea(
                  child: Scaffold(
                    body: Consumer<AddNewGroupBloc>(
                        builder: (context, bloc, child) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MARGIN_MEDIUM,
                          ),
                          AppBarSection(onTapBack: () {
                            Navigator.pop(context);
                          }, onTapCreate: () {
                            bloc.onTapCreated().then((value) {
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              showSnackBar(context, '$error');
                            });
                          }),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Group Name',
                                label: Text("Group Name"),
                              ),
                              onChanged: bloc.onChangedGroupName,
                            ),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: MARGIN_MEDIUM),
                              child: bloc.userList == null
                                  ? Center(
                                      child: Text("No Contant"),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: bloc.userList?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        var user = bloc.userList?[index];

                                        return ListTile(
                                          onTap: () {},
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              '${user?.profilePhoto}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text('${user?.userName}'),
                                          trailing: Checkbox(
                                            value: bloc.choosenUsers
                                                .contains(user),
                                            onChanged: (value) {
                                              bloc.onChangedCheckBox(
                                                  value ?? true,
                                                  user ?? UserVO());
                                            },
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: MARGIN_MEDIUM,
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: LoadingView(),
                ),
              ],
            );
          }),
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    Key? key,
    required this.onTapBack,
    required this.onTapCreate,
  }) : super(key: key);

  final Function onTapBack;
  final Function onTapCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            onTapBack();
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
        Text(
          'New Group',
          style: TextStyle(
            fontFamily: YorkieDEMO,
            fontWeight: FontWeight.w600,
            fontSize: TEXT_BIG,
            color: PRIMARY_COLOR,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            onPressed: () {
              onTapCreate();
            },
            child: Text(
              'Create',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
