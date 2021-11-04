// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/screens/category/widgets/filter_list_item.dart';

class FilterList extends StatefulWidget {
  final Function(List<String>) onSelect;

  const FilterList({Key key, this.onSelect}) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  List<String> selected = [];
  List<dynamic> options = [
    {
      'icon': SvgPicture.asset("assets/icons/new-sticker-svgrepo-com.svg"),
      'title': 'New product',
    },
    {
      'icon': SvgPicture.asset("assets/icons/fire-svgrepo-com.svg"),
      'title': 'Hot'
    },
  ];
  toggle(String title) {
    if (selected.contains(title)) {
      selected.remove(title);
    } else {
      selected.add(title);
    }

    setState(() {
      widget.onSelect(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((o) {
        return FilterListItem(
          icon: o['icon'],
          title: o['title'],
          selected: selected.contains(o['title']),
          onTap: () {
            toggle(o['title']);
          },
        );
      }).toList(),
    );
  }
}
