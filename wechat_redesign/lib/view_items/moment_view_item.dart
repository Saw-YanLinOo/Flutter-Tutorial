import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/moment_bloc.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';

import '../resources/dimens.dart';

class PostItemView extends StatelessWidget {
  const PostItemView({
    Key? key,
    this.moment,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  final MomentVO? moment;
  final Function onTapEdit;
  final Function onTapDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MARGIN_MEDIUM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        '${moment?.profilePicture}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${moment?.userName ?? 'User'}",
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: TEXT_REGULAR_2X,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_SMALL,
                        ),
                        Text(
                          "15 min ago",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: TEXT_REGULAR,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        onTapEdit();
                      },
                      child: Text("Edit"),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      onTap: () {
                        onTapDelete();
                      },
                      child: Text("Delete"),
                      value: 'delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Text(
              '${moment?.description ?? 'descriptions'}',
              style: TextStyle(
                color: PRIMARY_COLOR,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Visibility(
            visible: moment?.postImages != null &&
                (moment?.postImages?.isNotEmpty ?? false),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: moment?.postImages?.length ?? 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_2,
                ),
                itemBuilder: (context, index) {
                  var url = moment?.postImages?[index];
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MARGIN_CARD_MEDIUM_2)),
                    child: Image.network(url ?? ''),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MARGIN_MEDIUM,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.heart,
                      size: 24,
                    ),
                    SizedBox(
                      width: MARGIN_SMALL,
                    ),
                    Text(
                      '3',
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                        ),
                        SizedBox(
                          width: MARGIN_SMALL,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: TEXT_REGULAR_2X,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    Icon(
                      FontAwesomeIcons.bookmark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
