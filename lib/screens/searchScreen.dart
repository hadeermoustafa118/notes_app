import 'package:flutter/material.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firestore_search/firestore_search.dart';

import '../main.dart';
import '../models/dataModel.dart';
import '../presentation/colorManager.dart';
import 'editNote.dart';
import 'noteDetails.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        FirestoreSearchBar(
                          tag: 'example',
                        ),
                        Container(
                          height: 820.h,
                          width: 410.w,
                          child: FirestoreSearchResults.builder(
                            initialBody: const Center(child: Text('Search to find notes'),),
                            tag: 'example',
                            dataListFromSnapshot:
                                DataModel().dataListFromSnapshot,
                            firestoreCollectionName: 'flutterNotes',
                            searchBy: 'note_title',
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<DataModel>? dataList = snapshot.data;
                                if (dataList!.isEmpty) {
                                  return const Center(
                                    child: Text('No Results Returned' , style: TextStyle(color: Colors.black),),
                                  );
                                }
                                return
                                   ListView.builder(
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        final DataModel data = dataList[index];

                                        return InkWell(
                                          onTap: () {Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => NoteDetail(notes: cubit.notes[index] ,)),
                                          );},
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0).r,
                                            margin: const EdgeInsets.all(12.0).r,
                                            decoration: BoxDecoration(
                                                color: ColorManager.cardColors[
                                               data.id!
                                                  ],
                                                borderRadius:
                                                BorderRadius.circular(20.0)
                                                    .r),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                     '${data.title}',
                                                      style: TextStyle(
                                                          fontSize: 24.sp,
                                                          color: ColorManager
                                                              .txtColor,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                      maxLines: 1,
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      cubit.notes[index]
                                                      ['note_date'],
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: ColorManager
                                                              .txtColor),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0.w,
                                                    ),
                                                    Text(
                                                      cubit.notes[index]
                                                      ['note_time'],
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: ColorManager
                                                              .txtColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12.0.h,
                                                ),
                                                Text(
                                                  '${data.content}',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: ColorManager.txtColor,
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                );
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: Text('No Results Returned'),
                                  );
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.red,),
                              );
                            },
                          ),
                        )
                        // Container(
                        //   height: 400.h,
                        //   width: 400.w,
                        //   child: FutureBuilder(
                        //     future: notesRef
                        //         .where("user_id",
                        //             isEqualTo:
                        //                 FirebaseAuth.instance.currentUser!.uid)
                        //         .get(),
                        //     builder: (context, snapshot) {
                        //       return ListView.builder(
                        //         itemBuilder: (context, index) {
                        //           return cubit.searchController.text
                        //                       .toLowerCase() ==
                        //                   cubit.notes[index]['note_title']
                        //                       .toString()
                        //                       .toLowerCase()
                        //               ? InkWell(
                        //                   onTap: () {
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                           builder: (context) =>
                        //                               NoteDetail(
                        //                                 notes: cubit
                        //                                     .notesResult[index],
                        //                               )),
                        //                     );
                        //                   },
                        //                   child: Container(
                        //                     padding: const EdgeInsets.all(16.0).r,
                        //                     margin: const EdgeInsets.all(12.0).r,
                        //                     decoration: BoxDecoration(
                        //                         color: ColorManager.cardColors[
                        //                             cubit.notesResult[index]
                        //                                 ['color_id']],
                        //                         borderRadius:
                        //                             BorderRadius.circular(20.0)
                        //                                 .r),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Text(
                        //                           cubit.notesResult[index]
                        //                               ['note_title'],
                        //                           style: TextStyle(
                        //                               fontSize: 24.sp,
                        //                               color:
                        //                                   ColorManager.txtColor,
                        //                               fontWeight:
                        //                                   FontWeight.w500),
                        //                           maxLines: 1,
                        //                         ),
                        //                         SizedBox(
                        //                           height: 8.0.h,
                        //                         ),
                        //                         Row(
                        //                           children: [
                        //                             Text(
                        //                               cubit.notesResult[index]
                        //                                   ['note_date'],
                        //                               style: TextStyle(
                        //                                   fontSize: 14.sp,
                        //                                   color: ColorManager
                        //                                       .txtColor),
                        //                             ),
                        //                             SizedBox(
                        //                               width: 5.0.w,
                        //                             ),
                        //                             Text(
                        //                               cubit.notesResult[index]
                        //                                   ['note_time'],
                        //                               style: TextStyle(
                        //                                   fontSize: 14.sp,
                        //                                   color: ColorManager
                        //                                       .txtColor),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         SizedBox(
                        //                           height: 12.0.h,
                        //                         ),
                        //                         Text(
                        //                           cubit.notesResult[index]
                        //                               ['note_content'],
                        //                           style: TextStyle(
                        //                             fontSize: 18.sp,
                        //                             color: ColorManager.txtColor,
                        //                             fontWeight: FontWeight.w400,
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                           ),
                        //                           maxLines: 1,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 )
                        //               : Text('no data');
                        //         },
                        //         itemCount: cubit.notesResult.length,
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

// class search extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return Icon(Icons.search);
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Text('data');
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => AppCubit()..searchByTitle(),
//         child: BlocConsumer<AppCubit, AppStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               var cubit = AppCubit.get(context);
//               return FutureBuilder(
//                 future: notesRef
//                     .where("user_id",
//                         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                     .get(),
//                 builder: (context, snapshot) {
//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       return cubit.searchController.text.toLowerCase() ==
//                               cubit.notes[index]['note_title']
//                                   .toString()
//                                   .toLowerCase()
//                           ? InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => NoteDetail(
//                                             notes: cubit.notesResult[index],
//                                           )),
//                                 );
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(16.0).r,
//                                 margin: const EdgeInsets.all(12.0).r,
//                                 decoration: BoxDecoration(
//                                     color: ColorManager.cardColors[
//                                         cubit.notesResult[index]['color_id']],
//                                     borderRadius:
//                                         BorderRadius.circular(20.0).r),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       cubit.notesResult[index]['note_title'],
//                                       style: TextStyle(
//                                           fontSize: 24.sp,
//                                           color: ColorManager.txtColor,
//                                           fontWeight: FontWeight.w500),
//                                       maxLines: 1,
//                                     ),
//                                     SizedBox(
//                                       height: 8.0.h,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           cubit.notesResult[index]['note_date'],
//                                           style: TextStyle(
//                                               fontSize: 14.sp,
//                                               color: ColorManager.txtColor),
//                                         ),
//                                         SizedBox(
//                                           width: 5.0.w,
//                                         ),
//                                         Text(
//                                           cubit.notesResult[index]['note_time'],
//                                           style: TextStyle(
//                                               fontSize: 14.sp,
//                                               color: ColorManager.txtColor),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 12.0.h,
//                                     ),
//                                     Text(
//                                       cubit.notesResult[index]['note_content'],
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         color: ColorManager.txtColor,
//                                         fontWeight: FontWeight.w400,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       maxLines: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : Text('no data');
//                     },
//                     itemCount: cubit.notesResult.length,
//                   );
//                 },
//               );
//             }));
//   }
// }
