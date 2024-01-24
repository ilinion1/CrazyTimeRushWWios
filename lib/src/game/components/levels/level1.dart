import 'package:flutter/material.dart';
import 'package:crazy_time_rush/src/game/components/card_widget.dart';

class CtrLevel1 extends StatelessWidget {
  const CtrLevel1({
    super.key,
    required this.type,
    required this.cardFlips,
    required this.isDone,
    required this.success,
    required this.onItemPressed,
  });

  final List<int> type;
  final List<bool> cardFlips;
  final List<bool> isDone;
  final bool? success;
  final Function(int) onItemPressed;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 76),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        return CtrCardWidget(
          value: type[index],
          isFlipped: cardFlips[index],
          isDone: isDone[index],
          color: (success == null)
              ? Colors.black
              : success!
                  ? Colors.green
                  : Colors.red,
          onPressed: () async => await onItemPressed(index),
        );
      },
      itemCount: type.length,
    );
  }
}
