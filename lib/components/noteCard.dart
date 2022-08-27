import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class NoteCard extends StatelessWidget {
//   const NoteCard({Key? key,})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context, ) {
//     return Card(
//       child: Column(children: [
//         Text(doc["note_title"]),
//       ],),
//     );
//   }
// }

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 120.w,
      height: 180.h,
      padding: EdgeInsets.all(16.0).r,
      margin: EdgeInsets.all(12.0).r,
      decoration: BoxDecoration(
        color: ColorManager.cardColors[doc['color_id']],
        borderRadius: BorderRadius.circular(20.0).r
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc['note_title'],
            style: TextStyle(
                fontSize: 24.sp,
                color: ColorManager.txtColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.0.h,),
          Row(
            children: [
              Text(
                doc['note_date'],
                style: TextStyle(fontSize: 14.sp, color: ColorManager.txtColor),
              ),
              SizedBox(width: 5.0.w,),
              Text(
                doc['note_time'],
                style: TextStyle(fontSize: 14.sp, color: ColorManager.txtColor),
              ),
            ],
          ),
          SizedBox(height: 12.0.h,),
          Text(
            doc['note_content'],
            style: TextStyle(fontSize: 18.sp, color: ColorManager.txtColor, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, ),maxLines: 2,
          ),
        ],
      ),
    ),
  );
}
