// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:old_change_app/models/product.dart';
// import 'package:old_change_app/screens/detail_page/widgets/custom_icon_button.dart';

// class DetailPage extends StatefulWidget {
//   final Product item;
//   const DetailPage({Key key, @required this.item}) : super(key: key);

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   Product get item => widget.item;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [buildImage(item), buidAppbar(), buildProductInfo()],
//       ),
//     );
//   }

//   Widget buildProductInfo() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(
//           vertical: MediaQuery.of(context).size.height / 2 - 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               item.name,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               height: 12,
//             ),
//             Text('Price : \$${item.price}',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(
//               height: 12,
//             ),
//             Text(
//               'Quantity : ${item.quantity}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(
//               height: 12,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     RatingBar.builder(
//                         initialRating: item.rating,
//                         itemSize: 18,
//                         ignoreGestures: true,
//                         itemCount: 5,
//                         allowHalfRating: true,
//                         minRating: 1,
//                         unratedColor: Colors.amber[100],
//                         itemBuilder: (context, _) => Icon(
//                               Icons.star,
//                               size: 2,
//                               color: Colors.amber,
//                             ),
//                         onRatingUpdate: null),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       '${item.rating} Star',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 CustomIconButton(
//                   left1: 5,
//                   right1: 5,
//                   icon: Icon(
//                     Icons.remove,
//                     size: 16,
//                   ),
//                   onPressed: () {},
//                   backgroundColor: Colors.black.withOpacity(0.1),
//                 ),
//                 Text(
//                   '1',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 CustomIconButton(
//                     left1: 5,
//                     right1: 5,
//                     icon: Icon(
//                       Icons.add,
//                       size: 16,
//                     ),
//                     onPressed: () {},
//                     backgroundColor: Colors.black.withOpacity(0.1)),
//               ],
//             ),
//             buildDescreiption()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDescreiption() {
//     return Container(
//       margin: EdgeInsets.only(top: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Description',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(
//             height: 12,
//           ),
//           Text(item.description),
//         ],
//       ),
//     );
//   }

//   Widget buildImage(Product item) {
//     return Container(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height / 2,
//       child: Image.asset(
//         item.imagePath,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget buidAppbar() {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.only(left: 5, top: 5),
//         child: CustomIconButton(
//             left1: 10,
//             icon: Icon(Icons.arrow_back_ios),
//             backgroundColor: Colors.white,
//             onPressed: () => Navigator.of(context).pop()),
//       ),
//     );
//   }
// }
