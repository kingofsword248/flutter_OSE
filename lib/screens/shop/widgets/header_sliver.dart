import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/models/info.dart';
import 'package:old_change_app/screens/category/widgets/header.dart';
import 'package:old_change_app/screens/shop/widgets/header.dart';

class HeaderSliver2 implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final String content;
  final Info info;

  HeaderSliver2(
    this.info, {
    this.minExtent,
    @required this.maxExtent,
    this.content,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header2(
      content: content,
      info: info,
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
