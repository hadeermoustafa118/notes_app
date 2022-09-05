class DataModel {
  final String? title;
  final String? content;
  final int? id;


  DataModel({this.title, this.content, this.id});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot( querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return DataModel(
          title: dataMap['note_title'],
          content: dataMap['note_content'],
          id: dataMap['color_id']);
    }).toList();
  }
}