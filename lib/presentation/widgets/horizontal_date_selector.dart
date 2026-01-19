import 'package:flutter/material.dart';
import 'package:ten_twenty_task/presentation/widgets/date_pill.dart';

class DateOption {
  final String label;
  const DateOption({required this.label});
}

class HorizontalDateSelector extends StatelessWidget {
  final List<DateOption> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const HorizontalDateSelector({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (context, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final option = options[index];
          return DatePill(
            label: option.label,
            isSelected: index == selectedIndex,
            onTap: () => onSelected(index),
          );
        },
      ),
    );
  }
}

