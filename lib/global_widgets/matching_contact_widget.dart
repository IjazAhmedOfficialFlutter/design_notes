// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../data/model/user_model.dart';
// import '../screens/MessagesScreens/messages_details_screen.dart';
// import '../utilities/app_colors.dart';
// import '../utilities/app_text_styles_poppins.dart';
//
// class MatchingContactsWidget extends StatefulWidget {
//   final List<UserModel> matchingContacts;
//
//   const MatchingContactsWidget({super.key, required this.matchingContacts});
//
//   @override
//   State<MatchingContactsWidget> createState() => _MatchingContactsWidgetState();
// }
//
// class _MatchingContactsWidgetState extends State<MatchingContactsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: widget.matchingContacts.map((user) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 60,
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: user.userImg != null && user.userImg!.isNotEmpty
//                               ? NetworkImage(user.userImg!)
//                               : const AssetImage("assets/dummyImage.png") as ImageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         user.name ?? "Unknown Name", // Use user's name or fallback
//                         style: sixteen600TextStyle(color: Colors.black),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MessagesDetailsScreen(
//                               otherUserId: user.userId,
//
//                               currentUserID: FirebaseAuth.instance.currentUser?.uid ?? "",
//                               chatID: "${FirebaseAuth.instance.currentUser?.uid}-${user.userId}", // Example chat ID
//                               otherUserName: user.name??"",
//                             ),
//                           ),
//                         );
//                       },
//                       child: Image.asset(
//                         "assets/messageIcon.png",
//                         scale: 4,
//                         color: lightGreyColor,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Image.asset(
//                       "assets/callingIcon.png",
//                       scale: 4,
//                       color: lightGreyColor,
//                     ),
//                     const SizedBox(width: 10),
//                     Image.asset(
//                       "assets/videoCallingIcon.png",
//                       scale: 4,
//                       color: lightGreyColor,
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
