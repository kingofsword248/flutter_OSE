import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:old_change_app/models/feedback.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final List<FeedBackDTO> _list = [
    FeedBackDTO(
      idFeedBack: "1",
      content: "an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
    FeedBackDTO(
      idFeedBack: "2",
      content: "an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
    FeedBackDTO(
      idFeedBack: "3",
      content: "an lol con me no roi an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
    FeedBackDTO(
      idFeedBack: "4",
      content: "an lol con me no roi an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
    FeedBackDTO(
      idFeedBack: "5",
      content: "an lol con me no roi an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
    FeedBackDTO(
      idFeedBack: "6",
      content: "an lol con me no roi an lol con me no roi an lol con me no roi",
      image: "assets/images/user.png",
      name: "thuan dep trai",
      star: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text(
          "Review",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(_list[index].image),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_list[index].name),
                RatingBar.builder(
                    initialRating: _list[index].star,
                    itemSize: 12,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          size: 2,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: null),
              ],
            ),
            subtitle: Text(
              _list[index].content,
              overflow: TextOverflow.visible,
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
