import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 28),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.075),
          offset: Offset(0.0, 1.0),
          blurRadius: 10.0,
        )
      ]),
      child: TextFormField(
        decoration: InputDecoration(
          icon: SvgPicture.asset('assets/icons/search.svg'),
          hintText: 'Search product ....',
          hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 14.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
