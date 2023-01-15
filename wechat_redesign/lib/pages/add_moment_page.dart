import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/add_moment_bloc.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';
import 'package:wechat_redesign/widgets/loading_view.dart';

class AddMomentPage extends StatelessWidget {
  const AddMomentPage({
    Key? key,
    this.momentId,
  }) : super(key: key);

  final int? momentId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddMomentBloc(momentId),
      child: Selector<AddMomentBloc, bool>(
          selector: (p0, p1) => p1.loading,
          builder: (context, isLoading, child) {
            return Stack(
              children: [
                Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBarSection(
                            onTapBack: () {
                              Navigator.pop(context);
                            },
                            onTapCreate: () {
                              // var bloc = Provider.of<AddMomentBloc>(context,
                              //     listen: true);
                              context
                                  .read<AddMomentBloc>()
                                  .onTapCreate()
                                  .then((value) {
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                showSnackBar(context, '$error');
                              });
                            },
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_LARGE),
                            child: ProfileSection(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_LARGE),
                            child: MomentDescriptionSection(),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_CARD_MEDIUM_2),
                            child: MomentImageListSection(),
                          ),
                          SizedBox(
                            height: MARGIN_SMALL,
                          ),
                        ],
                      ),
                    ),
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

class MomentDescriptionSection extends StatelessWidget {
  const MomentDescriptionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMomentBloc>(builder: (context, bloc, child) {
      return TextField(
        controller: TextEditingController(text: bloc.description),
        maxLines: 12,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "What's in your mind?",
        ),
        onChanged: bloc.setDescription,
      );
    });
  }
}

class MomentImageListSection extends StatelessWidget {
  const MomentImageListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMomentBloc>(
      builder: (context, bloc, child) {
        return bloc.editMode
            ? ImageForEditMode(bloc: bloc)
            : ImageForAddMode(bloc: bloc);
      },
    );
  }
}

class ImageForAddMode extends StatelessWidget {
  const ImageForAddMode({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final AddMomentBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...bloc.chooseImageList.map(
            (image) {
              return Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          bloc.removeChooseImage(
                            bloc.chooseImageList.indexOf(image),
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ).toList(),
          GestureDetector(
            onTap: () async {
              // FilePickerResult? results = await FilePicker
              //     .platform
              //     .pickFiles(allowMultiple: true);
              // if (results != null) {
              //   bloc.setChooseFileList(results);
              // }

              List<XFile> images = await ImagePicker().pickMultiImage();

              bloc.setChooseImageList(images);
            },
            child: Container(
              width: 80,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageForEditMode extends StatelessWidget {
  const ImageForEditMode({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final AddMomentBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...bloc.postImages?.map(
                (image) {
                  return Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ).toList() ??
              [],
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMomentBloc>(builder: (context, bloc, child) {
      return Row(
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              '${bloc.profilePicture ?? ''}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            '${bloc.userName ?? ''}',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    });
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
    return Consumer<AddMomentBloc>(builder: (context, bloc, child) {
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
            'New Moments',
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
                bloc.editMode ? "Edit" : 'Create',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
