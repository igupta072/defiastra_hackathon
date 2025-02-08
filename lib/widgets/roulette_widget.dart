import 'dart:math';
import 'package:flutter/material.dart';

class CasinoRoulette extends StatefulWidget {
  final double balance;
  void Function(bool hasWon, num amount) onRoundComplete;

  CasinoRoulette(
      {super.key, required this.balance, required this.onRoundComplete});

  @override
  _CasinoRouletteState createState() => _CasinoRouletteState();
}

class _CasinoRouletteState extends State<CasinoRoulette>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  double _currentRotation = 0;
  bool _isSpinning = false;
  int _selectedChipValue = 10;
  final Map<String, List<int>> _bets = {};
  double _balance = 0;

  // European Roulette numbers and their colors
  final List<RouletteNumber> numbers = [
    RouletteNumber(0, Colors.green), // 0
    RouletteNumber(32, Colors.red), RouletteNumber(15, Colors.black),
    RouletteNumber(19, Colors.red), RouletteNumber(4, Colors.black),
    RouletteNumber(21, Colors.red), RouletteNumber(2, Colors.black),
    RouletteNumber(25, Colors.red), RouletteNumber(17, Colors.black),
    RouletteNumber(34, Colors.red), RouletteNumber(6, Colors.black),
    RouletteNumber(27, Colors.red), RouletteNumber(13, Colors.black),
    RouletteNumber(36, Colors.red), RouletteNumber(11, Colors.black),
    RouletteNumber(30, Colors.red), RouletteNumber(8, Colors.black),
    RouletteNumber(23, Colors.red), RouletteNumber(10, Colors.black),
    RouletteNumber(5, Colors.red), RouletteNumber(24, Colors.black),
    RouletteNumber(16, Colors.red), RouletteNumber(33, Colors.black),
    RouletteNumber(1, Colors.red), RouletteNumber(20, Colors.black),
    RouletteNumber(14, Colors.red), RouletteNumber(31, Colors.black),
    RouletteNumber(9, Colors.red), RouletteNumber(22, Colors.black),
    RouletteNumber(18, Colors.red), RouletteNumber(29, Colors.black),
    RouletteNumber(7, Colors.red), RouletteNumber(28, Colors.black),
    RouletteNumber(12, Colors.red), RouletteNumber(35, Colors.black),
    RouletteNumber(3, Colors.red), RouletteNumber(26, Colors.black),
  ];

  @override
  void initState() {
    super.initState();
    _balance = widget.balance;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller?.addListener(() => setState(() {}));
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isSpinning = false;
        _calculateWinnings();
      }
    });
  }

  void _calculateWinnings() {
    final winningNumber = _getWinningNumber();
    double winnings = 0;

    _bets.forEach((betPosition, chips) {
      if (_isBetWinning(betPosition, winningNumber)) {
        winnings += chips.fold(0, (sum, chip) => sum + chip) *
            _getBetMultiplier(betPosition);
      }
    });

    setState(() {
      _balance += winnings;
      if (winnings > 0) {
        widget.onRoundComplete(true, winnings);
      } else {
        widget.onRoundComplete(false, _selectedChipValue);
      }
      _bets.clear();
    });
  }

  double _getBetMultiplier(String betPosition) {
    if (betPosition.contains('-')) return 17.0; // Split
    if (betPosition.contains('column')) return 2.0; // Column
    if (betPosition.contains('dozen')) return 2.0; // Dozen
    if (['red', 'black', 'even', 'odd', '1-18', '19-36'].contains(betPosition))
      return 1.0;
    return 35.0; // Straight up
  }

  bool _isBetWinning(String betPosition, int winningNumber) {
    if (betPosition.contains('-')) {
      final numbers = betPosition.split('-').map(int.parse).toList();
      return numbers.contains(winningNumber);
    }

    final num = numbers[winningNumber];

    switch (betPosition) {
      case 'red':
        return num.color == Colors.red;
      case 'black':
        return num.color == Colors.black;
      case 'even':
        return winningNumber % 2 == 0 && winningNumber != 0;
      case 'odd':
        return winningNumber % 2 == 1;
      case '1-18':
        return winningNumber >= 1 && winningNumber <= 18;
      case '19-36':
        return winningNumber >= 19 && winningNumber <= 36;
      default:
        if (betPosition.contains('column')) {
          final column = int.parse(betPosition.substring(6));
          return winningNumber % 3 == column;
        }
        if (betPosition.contains('dozen')) {
          final dozen = int.parse(betPosition.substring(5));
          final start = (dozen - 1) * 12 + 1;
          return winningNumber >= start && winningNumber < start + 12;
        }
        return int.parse(betPosition) == winningNumber;
    }
  }

  int _getWinningNumber() {
    final anglePerNumber = 360.0 / numbers.length;
    final rawStoppingAngle = (_currentRotation % 360);
    final normalizedAngle = (360 - rawStoppingAngle) % 360;
    return (normalizedAngle ~/ anglePerNumber);
  }

  void spinWheel() {
    if (_isSpinning) return;
    if (_bets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Place your bets first!')),
      );
      return;
    }

    setState(() {
      _isSpinning = true;
    });

    final Random random = Random();
    final spins = random.nextInt(3) + 5;
    final extraAngle = random.nextDouble() * 360;
    final endRotation = spins * 360 + extraAngle;

    _animation = Tween<double>(
      begin: _currentRotation,
      end: _currentRotation + endRotation,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutCubic,
    ));

    _currentRotation += endRotation;
    _controller?.reset();
    _controller?.forward();
  }

  void _placeBet(String position) {
    if (_isSpinning) return;

    setState(() {
      if (_balance >= _selectedChipValue) {
        _balance -= _selectedChipValue;
        if (_bets.containsKey(position)) {
          _bets[position]!.add(_selectedChipValue);
        } else {
          _bets[position] = [_selectedChipValue];
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWheel(),
        const SizedBox(height: 20),
        _buildBettingTable(),
        const SizedBox(height: 20),
        _buildChipSelector(),
        const SizedBox(height: 20),
        _buildControlPanel(),
      ],
    );
  }

  Widget _buildWheel() {
    return SizedBox(
      height: 350,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ic_arrow_down.png',
            width: 30,
            height: 30,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _animation?.value ?? _currentRotation * (pi / 180),
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: RoulettePainter(numbers),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber, width: 2),
                ),
              )
            ],
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Image.asset(
          //     'assets/images/ic_arrow_down.png',
          //     width: 30,
          //     height: 30,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBettingTable() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        children: [
          _buildNumbersGrid(),
          const SizedBox(height: 8),
          _buildSpecialBets(),
        ],
      ),
    );
  }

  Widget _buildNumbersGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 13,
        childAspectRatio: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 39,
      // 0-36 plus 2 empty cells
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildBettingCell('0', Colors.green);
        }
        if (index < 37) {
          final number = numbers.firstWhere((n) => n.number == index);
          return _buildBettingCell(
            index.toString(),
            number.color,
          );
        }
        return Container(); // Empty cells
      },
    );
  }

  Widget _buildBettingCell(String number, Color color) {
    return GestureDetector(
      onTap: () => _placeBet(number),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_bets.containsKey(number))
              Positioned(
                right: 2,
                top: 2,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.yellow,
                  child: Text(
                    _bets[number]!.length.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialBets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSpecialBetButton('1-18', Colors.blue),
        _buildSpecialBetButton('Even', Colors.blue),
        _buildSpecialBetButton('Red', Colors.red),
        _buildSpecialBetButton('Black', Colors.black),
        _buildSpecialBetButton('Odd', Colors.blue),
        _buildSpecialBetButton('19-36', Colors.blue),
      ],
    );
  }

  Widget _buildSpecialBetButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () => _placeBet(text.toLowerCase()),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(text),
    );
  }

  Widget _buildChipSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [5, 10, 25, 50, 100].map((value) {
        return Padding(
          padding: EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () => setState(() => _selectedChipValue = value),
            child: _buildChip(value),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChip(int value) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _selectedChipValue == value ? Colors.yellow : Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '\$$value',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Balance: \$${_balance.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _isSpinning ? null : spinWheel,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(_isSpinning ? 'Spinning...' : 'SPIN!'),
            ),
            ElevatedButton(
              onPressed: _isSpinning
                  ? null
                  : () {
                      setState(() {
                        _bets.clear();
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Clear Bets'),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class RouletteNumber {
  final int number;
  final Color color;

  RouletteNumber(this.number, this.color);
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
