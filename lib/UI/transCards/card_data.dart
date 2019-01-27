import 'package:cloud_firestore/cloud_firestore.dart';
import "package:diary/constants/AppConstants.dart";



class DiaryDataModel {
  // final String CollectionlDIARY_DATA;
  final String lDATE;
  final String lCARD_CREATED_BY;
  final Timestamp lCARD_CREATED_AT;
  final String lCREATED_DAY;
  final bool lIS_READ_BY_CREATOR;
  final bool lIS_READ_BY_RECIEVER;
  final String lBG_URL;
  final String lLAST_EDIT_BY;
  final String lDOC_ID;

  DiaryDataModel(
      //this.Collection_DIARY_DATA,
      this.lDATE,
      this.lCARD_CREATED_BY,
      this.lCARD_CREATED_AT,
      this.lCREATED_DAY,
      this.lIS_READ_BY_CREATOR,
      this.lIS_READ_BY_RECIEVER,
      this.lBG_URL,
      this.lLAST_EDIT_BY,
      this.lDOC_ID);

  static List<DiaryDataModel> fromSnapShot(List<DocumentSnapshot> snapshot) {
    List<DiaryDataModel> diaryDatas = new List();
    diaryDatas.clear();
    for (int i = 0; i < snapshot.length; i++) {
      diaryDatas.add(new DiaryDataModel(
          snapshot[i][DATE_ID],
          snapshot[i][CARD_CREATED_BY],
          snapshot[i][CARD_CREATED_AT],
          snapshot[i][CREATED_DAY],
          snapshot[i][IS_READ_BY_CREATOR],
          snapshot[i][IS_READ_BY_RECIEVER],
          snapshot[i][BG_URL],
          snapshot[i][LAST_EDIT_BY],
          ""));
    }
    return diaryDatas.reversed.toList(growable: true);
  }
}
