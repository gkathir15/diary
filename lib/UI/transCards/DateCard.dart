import 'package:flutter/material.dart';
import 'card_data.dart';

class DateCard extends StatelessWidget {
  final CardViewModel viewModel;
  final double parallaxPercent; // [0.0, 1.0] (0.0 for all the way right, 1.0 for all the way left)

  DateCard({
    this.viewModel,
    this.parallaxPercent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Background
        new ClipRRect(
          borderRadius: new BorderRadius.circular(10.0),
          child: new Container(
            child: new FractionalTranslation(
              translation: new Offset(parallaxPercent * 2.0, 0.0),
              child: new OverflowBox(
                maxWidth: double.infinity,
                child: new Image.asset(
                  viewModel.backdropAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        // Content
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: new Text(
                '${viewModel.address}'.toUpperCase(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'petita',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            new Expanded(child: new Container()),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(
                  '${viewModel.minHeightInFeet} - ${viewModel.maxHeightInFeet}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 140.0,
                    fontFamily: 'petita',
                    letterSpacing: -5.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                  child: new Text(
                    'FT',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'petita',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Icon(
                  Icons.wb_sunny,
                  color: Colors.white,
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new Text(
                    '${viewModel.tempInDegrees.toStringAsFixed(1)}º',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'petita',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
              child: new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  border: new Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: new Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Text(
                        '${viewModel.weatherType}',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'petita',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: new Icon(
                          Icons.wb_cloudy,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        '${viewModel.windSpeedInMph}mph ${viewModel.cardinalDirection}',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'petita',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


