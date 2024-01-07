// import 'package:flutter/material.dart';
//
// class SignInButton extends StatelessWidget {
//
//   SignInButton(this.logo,this.socialMedia,this.onPressed);
//
//     String logo ='';
//     String socialMedia = '';
//     Function onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlineButton(
//       splashColor: Colors.grey,
//       onPressed: onPressed,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       highlightElevation: 0,
//       borderSide: BorderSide(color: Colors.grey),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image(image: AssetImage(logo),height: 15,),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 socialMedia,
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: Colors.grey,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
