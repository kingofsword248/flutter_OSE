// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/input/feedback_form.dart';
import 'package:old_change_app/models/input/product_detail.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/presenters/load_feedback_presenter.dart';
import 'package:old_change_app/screens/detail_page/widgets/add_cart.dart';
import 'package:old_change_app/screens/detail_page/widgets/owner_card.dart';
import 'package:old_change_app/screens/feedback/feedback.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:readmore/readmore.dart';

class ProductInfo extends StatefulWidget {
  final ProductDetail item;
  const ProductInfo({Key key, this.item}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo>
    implements LoadFeedBackContract {
  LoadFeedBackPresenter _feedBackPresenter;
  bool isLoad = true;
  FeedbackForm feedbackForm;
  @override
  void initState() {
    _feedBackPresenter = LoadFeedBackPresenter(this);

    // TODO: implement initState
    super.initState();
    _feedBackPresenter.onLoad(widget.item.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Text(
            '${widget.item.name}',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              NumberFormat.simpleCurrency(locale: 'vi')
                  .format(widget.item.price),
              style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (!isLoad)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: feedbackForm.aVGStar,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: null,
                    ),
                    Text(
                      '(${feedbackForm.aVGStar})',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                OutlineButton(
                  textColor: primaryColor,
                  color: primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedBack(
                                  list: feedbackForm,
                                )));
                  },
                  child: Text("Feedback"),
                )
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.1),
            //         offset: Offset.zero,
            //         blurRadius: 15.0,
            //       ),
            //     ],
            //     borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quantity : " + widget.item.quantity.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Description ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMoreText(
                  widget.item.description,
                  trimLines: 6,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: ' Less',
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 15,
                      letterSpacing: 1,
                      height: 1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CardOwner(
            product: widget.item,
          ),
          AddCart(
            product: widget.item,
          )
        ],
      ),
    );
  }

  @override
  void onLoadFeedbackError(String error) {
    print(error);
  }

  @override
  void onloadFeedBackSuccess(FeedbackForm form) {
    setState(() {
      feedbackForm = form;
      isLoad = false;
    });
  }
}
