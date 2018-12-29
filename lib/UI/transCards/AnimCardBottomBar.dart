import 'package:flutter/material.dart';


class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,left: 30.0, right: 30.0),
        child:  new Row(
    children: <Widget>[
        new Expanded(
        child: new Center(
        child: new Container(
        width: double.infinity,
          height: 5.0,
          child: new ScrollIndicator(
            cardCount: cardCount,
            scrollPercent: scrollPercent,
          ),
        ),
      ),
    ),
    ],
    ))
         );
  }
}

class ScrollIndicator extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: new Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  })
      : trackPaint = new Paint()
    ..color = const Color(0xFF444444)
    ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double rad = 5.0;
    // Draw track
    canvas.drawRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: new Radius.circular(rad),
        topRight: new Radius.circular(rad),
        bottomLeft: new Radius.circular(rad),
        bottomRight: new Radius.circular(rad),
      ),
      trackPaint,
    );

    // Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    Path thumbPath = new Path();
    thumbPath.addRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          thumbLeft,
          0.0,
          thumbWidth,
          size.height,
        ),
        topLeft: new Radius.circular(rad),
        topRight: new Radius.circular(rad),
        bottomLeft: new Radius.circular(rad),
        bottomRight: new Radius.circular(rad),
      ),
    );

    // Thumb shape
    canvas.drawPath(
      thumbPath,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}