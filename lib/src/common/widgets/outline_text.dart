import 'package:flutter/material.dart';

class CtrOutlinedText extends StatelessWidget {
  const CtrOutlinedText({
    super.key,
    required this.text,
    required this.textStyle,
    this.strokeWidth = 5,
  });

  final String text;
  final TextStyle textStyle;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle.merge(
            TextStyle(
              letterSpacing: 1,
              fontFamily: 'Campton Bold',
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeCap = StrokeCap.round
                ..strokeWidth = strokeWidth
                ..color = const Color(0xFF150093),
            ),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle.merge(
            const TextStyle(
              letterSpacing: 1,
              fontFamily: 'Campton Bold',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
