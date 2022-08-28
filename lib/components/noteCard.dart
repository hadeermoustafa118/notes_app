// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:notes_app/cubit/appCubit.dart';
// import 'package:notes_app/cubit/appStates.dart';
// import '../presentation/colorManager.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../screens/editNote.dart';
//
// class NoteCard extends StatelessWidget {
//    NoteCard({Key? key,})
//       : super(key: key);
// //   final Function onTap;
// //   final int index;
// //   final String docId;
// // final  notes;
//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return BlocProvider(
//       create: (BuildContext context) => AppCubit()..getData(),
//       child: BlocConsumer<AppCubit, AppStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var cubit = AppCubit.get(context);
//             return InkWell(
//               onTap: () {},
//               child: Container(
//                 padding: EdgeInsets.all(16.0).r,
//                 margin: EdgeInsets.all(12.0).r,
//                 decoration: BoxDecoration(
//                     color: ColorManager.cardColors[
//                     notes['color_id']],
//                     borderRadius:
//                     BorderRadius.circular(20.0).r),
//                 child: Column(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           notes['note_title'],
//                           style: TextStyle(
//                               fontSize: 24.sp,
//                               color: ColorManager.txtColor,
//                               fontWeight: FontWeight.w500),
//                           maxLines: 1,
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               // debugPrint('from card $docId');
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //       builder: (context) =>
//                               //        EditNote(docId:docId)),
//                               // );
//                             },
//                             icon: Icon(
//                               Icons.edit_note_outlined,
//                               size: 28.r,
//                             ))
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8.0.h,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           notes['note_date'],
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: ColorManager.txtColor),
//                         ),
//                         SizedBox(
//                           width: 5.0.w,
//                         ),
//                         Text(
//                           notes['note_time'],
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: ColorManager.txtColor),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 12.0.h,
//                     ),
//                     Text(
//                       notes['note_content'],
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: ColorManager.txtColor,
//                         fontWeight: FontWeight.w400,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       maxLines: 1,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
