import 'dart:math' as math;
import 'dart:math';
import 'package:defiastra_hackathon/widgets/roulette_widget.dart';
import 'package:flutter/material.dart';

class MySpinner extends StatefulWidget {
  final MySpinController mySpinController;
  final List<RouletteNumber> itemList;
  final double wheelSize;
  final void Function(AnimationController) onAnimationCompleted;
  const MySpinner({
    Key? key,
    required this.mySpinController,
    required this.itemList,
    required this.wheelSize,
    required this.onAnimationCompleted
  }) : super(key: key);

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> with TickerProviderStateMixin{

  // @override
  // void initState() {
  //   super.initState();
  //   widget.mySpinController.initLoad(
  //     tickerProvider: this,
  //     itemList: widget.itemList,
  //   ).then((_) {
  //     widget.mySpinController.baseAnimation.addListener(() => setState(() {}));
  //     widget.mySpinController.baseAnimation.addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         print("INDRAA :: $status");
  //         widget.mySpinController.xSpinning = false;
  //         widget.onAnimationCompleted(widget.mySpinController.baseAnimation);
  //       }
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Stack(
      //alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: widget.mySpinController.baseAnimation,
            builder: (context, child) {
              double value = widget.mySpinController.baseAnimation.value;
              double rotationValue = (360 * value);
              return RotationTransition(
                turns: AlwaysStoppedAnimation( rotationValue / 360 ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        width: widget.wheelSize,
                        height: widget.wheelSize,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),

                        padding: const EdgeInsets.all(5),
                        child: CustomPaint(
                          painter: RoulettePainter(
                              widget.itemList
                          ),
                        ),
                      ),
                    ),
                    ...widget.itemList.map((each) {
                      int index = widget.itemList.indexOf(each);
                      double rotateInterval = 360 / widget.itemList.length;
                      double rotateAmount = (index + 0.5) * rotateInterval;
                      return RotationTransition(
                        turns: AlwaysStoppedAnimation(rotateAmount/360),
                        child: Transform.translate(
                          offset: Offset(0,-widget.wheelSize/4),
                          child: const RotatedBox(
                            quarterTurns: 3,
                          ),
                        ),
                      );
                    }).toList(),
                    Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(0),
            child: const Icon(Icons.location_on_sharp,size: 50,color: Colors.blue,)),
      ],
    );
  }
}

class MySpinController{

  late AnimationController baseAnimation;
  late TickerProvider _tickerProvider;
  bool xSpinning = false;
  List<RouletteNumber> _itemList = [];
  int luckyIndex = 0;

  Future<void> initLoad({
    required TickerProvider tickerProvider,
    required List<RouletteNumber> itemList,
  }) async{
    _tickerProvider = tickerProvider;
    _itemList = itemList;
    await setAnimations(_tickerProvider);
  }

  Future<void> setAnimations(TickerProvider tickerProvider) async{
    baseAnimation = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<void> spinNow({
    required int luckyIndex,
    int totalSpin = 10,
    int baseSpinDuration = 100
  }) async{
    this.luckyIndex = luckyIndex;
    //getWhereToStop
    int itemsLength = _itemList.length;
    int factor = luckyIndex % itemsLength;
    if(factor == 0) factor = itemsLength;
    double spinInterval = 1 / itemsLength;
    double target = 1 - ( (spinInterval * factor) - (spinInterval/2));

    if(!xSpinning){
      xSpinning = true;
      int spinCount = 0;

      do{
        baseAnimation.reset();
        baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        if(spinCount == totalSpin){
          xSpinning = false;
          await baseAnimation.animateTo(target);
        }
        else{
          await baseAnimation.forward();
        }
        baseSpinDuration = baseSpinDuration + 50;
        baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        spinCount++;
      }
      while(spinCount <= totalSpin);

      xSpinning = false;
    }
  }

}

class RoulettePainter extends CustomPainter {
  final List<RouletteNumber> numbers;

  RoulettePainter(this.numbers);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double anglePerNumber = 2 * pi / numbers.length;

    // ... (continuing from the RoulettePainter class)
    for (int i = 0; i < numbers.length; i++) {
      final paint = Paint()
        ..color = numbers[i].color
        ..style = PaintingStyle.fill;

      // Draw the segment
      final path = Path();
      path.moveTo(centerX, centerY);
      path.arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        i * anglePerNumber,
        anglePerNumber,
        false,
      );
      path.lineTo(centerX, centerY);
      canvas.drawPath(path, paint);

      // Draw the number
      final textPainter = TextPainter(
        text: TextSpan(
          text: numbers[i].number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // Position the text
      final double textAngle = i * anglePerNumber + (anglePerNumber / 2);
      final double textRadius = radius * 0.75;
      final double x = centerX + textRadius * cos(textAngle);
      final double y = centerY + textRadius * sin(textAngle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(textAngle + pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Draw outer circle
    final outerCirclePaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      outerCirclePaint,
    );

    // Draw inner circle
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius * 0.1,
      Paint()..color = Colors.amber,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
