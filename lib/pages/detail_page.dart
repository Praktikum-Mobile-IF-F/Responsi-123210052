// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:responsi/models/colors.dart';
// import 'package:responsi/controllers/favorite.dart';
// import 'package:responsi/models/kopi.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DetailScreen extends StatefulWidget {
//   final Coffee coffee;
//
//   const DetailScreen({
//     Key? key,
//     required this.coffee,
//   }) : super(key: key);
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   late bool isBookmarked = false;
//   late Map<String, dynamic> _userData = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//     _checkIfBookmarked();
//   }
//
//   Future<void> _loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userDataString = prefs.getString('loggedInUserData');
//     if (userDataString != null) {
//       setState(() {
//         _userData = json.decode(userDataString);
//       });
//     }
//   }
//
//   Future<void> _checkIfBookmarked() async {
//     final favoriteBox = await Hive.openBox<Favorite>('favoriteBox');
//     final favorite = favoriteBox.get(_userData['email']);
//     setState(() {
//       isBookmarked = favorite?.coffees.any((coffee) => coffee.id == widget.coffee.id) ?? false;
//     });
//   }
//
//   void _toggleBookmark() async {
//     final favoriteBox = await Hive.openBox<Favorite>('favoriteBox');
//     setState(() {
//       isBookmarked = !isBookmarked;
//     });
//
//     Favorite? favorite = favoriteBox.get(_userData['email']);
//     if (isBookmarked) {
//       if (favorite == null) {
//         favorite = Favorite(email: _userData['email'], coffees: [convertCoffee(widget.coffee)]);
//         favoriteBox.put(_userData['email'], favorite);
//       } else {
//         favorite.coffees.add(convertCoffee(widget.coffee));
//         favorite.save();
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Added to favorites'),
//         ),
//       );
//     } else {
//       if (favorite != null) {
//         favorite.coffees.removeWhere((coffee) => coffee.id == widget.coffee.id);
//         favorite.save();
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Removed from favorites'),
//         ),
//       );
//     }
//   }
//
//   Coffee convertCoffee(Coffee coffee) {
//     return Coffee(
//       id: coffee.id!,
//       //coffeeId: coffee.idcoffee!,
//       name: coffee.name ?? '',
//       description: coffee.description ?? '',
//       price: coffee.price ?? 0,
//       region: coffee.region ?? '',
//       weight: coffee.weight ?? 0,
//       flavorProfile: coffee.flavorProfile ?? [],
//       grindOption: coffee.grindOption ?? [],
//       roastLevel: coffee.roastLevel ?? 0,
//       imageUrl: coffee.imageUrl ?? 'No Image Available',
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail'),
//         actions: [
//           IconButton(
//             onPressed: _toggleBookmark,
//             icon: Icon(
//               isBookmarked ? Icons.favorite : Icons.favorite_border,
//               color: isBookmarked ? primaryColor : null,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 7,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//                 color: Colors.white,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     widget.coffee.imageUrl ?? 'No Image Available',
//                     width: 200,
//                     height: 100,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               widget.coffee.name ?? 'No Title',
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               widget.coffee.description ?? 'No Description',
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.black54,
//               ),
//             ),
//             Text(
//               '\$${widget.coffee.price}',
//               style: const TextStyle(
//                 fontSize: 17,
//                 color: Colors.black54,
//               ),
//             ),
//             Text(
//               '${widget.coffee.region ?? 'No Location'}',
//               style: const TextStyle(
//                 fontSize: 17,
//                 color: Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Flavor Profile',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Column(
//               children: widget.coffee.flavorProfile
//                   ?.map((flavor) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     Expanded(
//                       child: Text(
//                         '- $flavor',
//                         style: const TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//                   .toList() ?? [Text('No Flavor Profile Available')],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Grind Option',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Column(
//               children: widget.coffee.grindOption
//                   ?.map((grind) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     Expanded(
//                       child: Text(
//                         '- $grind',
//                         style: const TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//                   .toList() ?? [Text('No Grind Option Available')],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Roast Level',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '${widget.coffee.roastLevel ?? 'No Roast Level Available'}',
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose(){
//     Hive.close();
//     super.dispose();
//   }
// }
