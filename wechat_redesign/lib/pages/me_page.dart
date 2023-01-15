import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wechat_redesign/blocs/me_bloc.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/moment_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/view_items/moment_view_item.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeBloc(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_3, vertical: MARGIN_MEDIUM),
                child: AppBarSection(onTapEdit: () {}),
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              Selector<MeBloc, UserVO?>(
                  selector: (p0, p1) => p1.mUser,
                  builder: (context, mUser, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: UserDetailSection(
                        user: mUser,
                      ),
                    );
                  }),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Text(
                  'Bookmarked Moments',
                  style: TextStyle(
                    fontFamily: YorkieDEMO,
                    color: PRIMARY_COLOR,
                    fontSize: TEXT_HEADING_1X,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostItemView(
                    onTapDelete: () {},
                    onTapEdit: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailSection extends StatelessWidget {
  const UserDetailSection({
    Key? key,
    this.user,
  }) : super(key: key);

  final UserVO? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(MARGIN_MEDIUM),
                child: Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    '${user?.profilePhoto}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: QrImage(
                                  data: '${user?.id}',
                                  size: 200,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: QrImage(
                    data: '${user?.id}',
                    size: 60,
                    backgroundColor: Colors.white,
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
                '${user?.userName ?? 'user name'}',
                style: TextStyle(
                  fontFamily: YorkieDEMO,
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                ),
              ),
              SizedBox(
                height: MARGIN_CARD_MEDIUM,
              ),
              ProfileDetailItemView(
                iconData: Icons.phone_android,
                value: '${user?.phoneNumber ?? '097 81043781'}',
              ),
              SizedBox(
                height: MARGIN_CARD_MEDIUM,
              ),
              ProfileDetailItemView(
                iconData: Icons.calendar_month,
                value: '${user?.dateOfBirth ?? '2001-01-31'}',
              ),
              SizedBox(
                height: MARGIN_CARD_MEDIUM,
              ),
              ProfileDetailItemView(
                iconData: Icons.yard,
                value: '${user?.gender ?? 'gender'}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileDetailItemView extends StatelessWidget {
  const ProfileDetailItemView({
    Key? key,
    required this.iconData,
    this.value,
  }) : super(key: key);

  final IconData iconData;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM,
        ),
        Text(
          value ?? '',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    Key? key,
    required this.onTapEdit,
  }) : super(key: key);

  final Function onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ME',
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
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
