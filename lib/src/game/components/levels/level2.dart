import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/game/components/card_widget.dart';

class CtrLevel2 extends StatefulWidget {
  const CtrLevel2({
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
  State<CtrLevel2> createState() => _CtrLevel2State();
}

class _CtrLevel2State extends State<CtrLevel2> {
  // for row start
  int lastIndex = 0;

  int calculateRows(int columnIndex) {
    switch (columnIndex) {
      case 1 || 6:
        return 2;
      case 2 || 5:
        return 4;
      case 3 || 4:
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          6,
          (columnIndex) {
            if (columnIndex == 0) lastIndex = 0;
            lastIndex += calculateRows(columnIndex);
            // print('Last index: $lastIndex');
            final rows = calculateRows(columnIndex + 1);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                (rows),
                (index) {
                  // print('Current index: $index');
                  print(widget.type);
                  final itemIndex = lastIndex + index;
                  return CtrCardWidget(
                    value: widget.type[itemIndex],
                    isFlipped: widget.cardFlips[itemIndex],
                    isDone: widget.isDone[itemIndex],
                    color: (widget.success == null)
                        ? Colors.black
                        : widget.success!
                            ? Colors.green
                            : Colors.red,
                    onPressed: () => widget.onItemPressed(itemIndex),
                  );
                },
              ),
            );
          },
          growable: false,
        ),
      ),
    );
  }
}
