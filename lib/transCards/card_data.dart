final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'https://images.unsplash.com/photo-1545647274-96644da34363?ixlib=rb-1.2.1&auto=format&fit=crop&w=1406&q=80',
    address: '10TH STREET',
    minHeightInFeet: 2,
    maxHeightInFeet: 3,
    tempInDegrees: 65.1,
    weatherType: "Mostly Cloudy",
    windSpeedInMph: 11.2,
    cardinalDirection: "ENE",
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/dusk_waves.jpg',
    address: '10TH STREET NORTH\nTO 14TH STREET NO...',
    minHeightInFeet: 6,
    maxHeightInFeet: 7,
    tempInDegrees: 54.5,
    weatherType: "Rain",
    windSpeedInMph: 20.5,
    cardinalDirection: "E",
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/board_walk.jpg',
    address: 'BELLS BEACH',
    minHeightInFeet: 3,
    maxHeightInFeet: 4,
    tempInDegrees: 61.0,
    weatherType: "Sunny",
    windSpeedInMph: 19.9,
    cardinalDirection: "W",
  ),

  new CardViewModel(
    backdropAssetPath: 'assets/van_on_beach.jpg',
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
