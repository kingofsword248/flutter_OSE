import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/screens/category/test/test_search.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String search = "";
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
        initialValue: search,
        onSaved: (newValue) {
          search = newValue;
        },
        onChanged: (value) {
          search = value;
        },
        onFieldSubmitted: (value) {
          search = value;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TestSearch(
                        title: "Search",
                        keyword: search,
                        list: null,
                      )));
        },
        decoration: InputDecoration(
          icon: InkWell(
            child: SvgPicture.asset('assets/icons/search.svg'),
            onTap: () {},
          ),
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
