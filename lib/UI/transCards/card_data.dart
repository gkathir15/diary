import 'package:cloud_firestore/cloud_firestore.dart';
import "package:diary/constants/AppConstants.dart";

final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'assets/jpgs/1.jpg',
    address: '10TH STREET',
    minHeightInFeet: 2,
    maxHeightInFeet: 3,
    tempInDegrees: 65.1,
    weatherType: "Mostly Cloudy",
    windSpeedInMph: 11.2,
    cardinalDirection: "ENE",
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/jpgs/2.jpg',
    address: '10TH STREET NORTH\nTO 14TH STREET NO...',
    minHeightInFeet: 6,
    maxHeightInFeet: 7,
    tempInDegrees: 54.5,
    weatherType: "Rain",
    windSpeedInMph: 20.5,
    cardinalDirection: "E",
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/jpgs/3.jpg',
    address: 'BELLS BEACH',
    minHeightInFeet: 3,
    maxHeightInFeet: 4,
    tempInDegrees: 61.0,
    weatherType: "Sunny",
    windSpeedInMph: 19.9,
    cardinalDirection: "W",
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/jpgs/4.jpg',
    address: '20TH STREET',
    minHeightInFeet: 2,
    maxHeightInFeet: 3,
    tempInDegrees: 65.1,
    weatherType: "Mostly Rainy",
    windSpeedInMph: 11.2,
    cardinalDirection: "ENE",
  ),
];

class CardViewModel {
  final String backdropAssetPath;
  final address;
  final int minHeightInFeet;
  final int maxHeightInFeet;
  final double tempInDegrees;
  final String weatherType;
  final double windSpeedInMph;
  final String cardinalDirection;

  CardViewModel({
    this.backdropAssetPath,
    this.address,
    this.minHeightInFeet,
    this.maxHeightInFeet,
    this.tempInDegrees,
    this.weatherType,
    this.windSpeedInMph,
    this.cardinalDirection,
  });
}

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
    return diaryDatas;
  }
}
