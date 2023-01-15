import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/moment_bloc.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';
import 'package:wechat_redesign/view_items/moment_view_item.dart';

import '../resources/dimens.dart';
import 'add_moment_page.dart';

class MomentPage extends StatelessWidget {
  const MomentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MomentBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Moments',
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
                navigateToScreen(context, const AddMomentPage());
              },
              child: Image.asset('assets/icons/moment_action.png'),
            ),
          ],
        ),
        body: Consumer<MomentBloc>(builder: (context, bloc, child) {
          return ListView.separated(
            itemCount: bloc.moments?.length ?? 0,
            itemBuilder: (context, index) {
              var moment = bloc.moments?[index];

              return PostItemView(
                moment: moment,
                onTapDelete: () {
                  bloc.onTapDelete(moment?.id ?? 0);
                },
                onTapEdit: () {
                  Timer(const Duration(seconds: 1), () {
                    navigateToScreen(
                        context, AddMomentPage(momentId: moment?.id));
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        }),
      ),
    );
  }
}
