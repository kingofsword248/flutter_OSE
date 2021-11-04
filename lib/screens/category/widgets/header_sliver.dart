import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:old_change_app/screens/category/widgets/header.dart';

class HeaderSliver implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final String content;
  HeaderSliver({this.minExtent, @required this.maxExtent, this.content});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header(
      content: content,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}
