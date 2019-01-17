final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath:  'assets/jpgs/1.jpg',
    address: '10TH STREET',
    minHeightInFeet: 2,
    maxHeightInFeet: 3,
    tempInDegrees: 65.1,
    weatherType: "Mostly Cloudy",
    windSpeedInMph: 11.2,
    cardinalDirection: "ENE",
  ),
  new CardViewModel(
    backdropAssetPath:  'assets/jpgs/2.jpg',
    address: '10TH STREET NORTH\nTO 14TH STREET NO...',
    minHeightInFeet: 6,
    maxHeightInFeet: 7,
    tempInDegrees: 54.5,
    weatherType: "Rain",
    windSpeedInMph: 20.5,
    cardinalDirection: "E",
  ),
  new CardViewModel(
    backdropAssetPath:  'assets/jpgs/3.jpg',
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


class DiaryDataModel{
  final String Collection_DIARY_DATA;
  final String FIELD_ID;
  final String CARD_CREATED_BY;

  final String CARD_CREATED_AT;

  final String CREATED_DAY;

  final String IS_READ_BY_CREATOR;

  final String IS_READ_BY_RECIEVER;

  final String BG_URL;

  final String LAST_EDIT_BY;

  DiaryDataModel(this.Collection_DIARY_DATA, this.FIELD_ID,
      this.CARD_CREATED_BY, this.CARD_CREATED_AT, this.CREATED_DAY,
      this.IS_READ_BY_CREATOR, this.IS_READ_BY_RECIEVER, this.BG_URL,
      this.LAST_EDIT_BY);


}
