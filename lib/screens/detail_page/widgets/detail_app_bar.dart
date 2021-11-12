import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:old_change_app/models/product_real.dart';

class DetailAppBar extends StatefulWidget {
  final Product item;
  const DetailAppBar({Key key, this.item}) : super(key: key);

  @override
  _DetailAppBarState createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  height: 450,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  }),
              items: widget.item.images
                  .map((f) => Builder(
                      builder: (context) => Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  // ignore: unnecessary_string_interpolations
                                  image: NetworkImage('${f.address}'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          )))
                  .toList(),
            ),
          ),
          Positioned(
              bottom: 30,
              left: 180,
              child: Row(
                children: widget.item.images
                    .asMap()
                    .entries
                    .map((entry) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(
                                  _currentPage == entry.key ? 0.9 : 0.4)),
                        ))
                    .toList(),
              )),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 5,
              left: 15,
              right: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
