import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:old_change_app/models/feedback.dart';
import 'package:old_change_app/models/input/feedback_form.dart';

class FeedBack extends StatelessWidget {
  final FeedbackForm list;
  const FeedBack({Key key, @required this.list}) : super(key: key);

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
        itemCount: list.listFeedback.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: list.listFeedback[index].avatar != null
                  ? NetworkImage(list.listFeedback[index].avatar)
                  : const AssetImage("assets/images/user.png"),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(list.listFeedback[index].fullName),
                RatingBar.builder(
                    initialRating:
                        double.parse(list.listFeedback[index].star.toString()),
                    itemSize: 12,
                    ignoreGestures: true,
                    allowHalfRating: false,
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
            subtitle: Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.listFeedback[index].content,
                    overflow: TextOverflow.visible,
                  ),
                  list.listFeedback[index].image.isNotEmpty
                      ? Container(
                          alignment: Alignment.centerLeft,
                          // width: double.infinity,
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: list.listFeedback[index].image.length,
                            itemBuilder: (context, index2) => Container(
                              height: 100,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.network(list
                                    .listFeedback[index].image[index2].address),
                                // height: 100,
                              ),
                            ),
                          ),
                        )
                      : Text("")
                ],
              ),
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}




  // final List<FeedBackDTO> _list = [
  //   FeedBackDTO(
  //     idFeedBack: "1",
  //     content: "an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  //   FeedBackDTO(
  //     idFeedBack: "2",
  //     content: "an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  //   FeedBackDTO(
  //     idFeedBack: "3",
  //     content: "an lol con me no roi an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  //   FeedBackDTO(
  //     idFeedBack: "4",
  //     content: "an lol con me no roi an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  //   FeedBackDTO(
  //     idFeedBack: "5",
  //     content: "an lol con me no roi an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  //   FeedBackDTO(
  //     idFeedBack: "6",
  //     content: "an lol con me no roi an lol con me no roi an lol con me no roi",
  //     image: "assets/images/user.png",
  //     name: "thuan dep trai",
  //     star: 3,
  //   ),
  // ];
  // List<String> hinhs = [
  //   "assets/images/not.png",
  //   "assets/images/not.png",
  //   "assets/images/not.png",
  //   "assets/images/not.png"
  // ];
