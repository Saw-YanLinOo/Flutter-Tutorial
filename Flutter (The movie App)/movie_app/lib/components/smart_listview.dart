import 'package:flutter/material.dart';

class SmartHorizontalListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onReachEnd;
  final Axis? scrollDirection;
  const SmartHorizontalListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.padding,
    required this.onReachEnd,
    this.scrollDirection,
    Key? key,
  }) : super(key: key);

  @override
  State<SmartHorizontalListView> createState() =>
      _SmartHorizontalListViewState();
}

class _SmartHorizontalListViewState extends State<SmartHorizontalListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          debugPrint("Start of the listview");
        } else {
          debugPrint("End of the listview");
          widget.onReachEnd();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection ?? Axis.vertical,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
      padding: widget.padding,
    );
  }
}
