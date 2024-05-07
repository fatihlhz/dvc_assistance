import 'package:flutter/material.dart';

class StatPointWidget extends StatefulWidget {
  final Function(int) callback;

  StatPointWidget({super.key, required this.callback});

  @override
  State<StatPointWidget> createState() => _StatPointWidgetState();
}

class _StatPointWidgetState extends State<StatPointWidget> {
  int point = 9;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: const <ButtonSegment<int>>[
        ButtonSegment<int>(value: 3, label: Text('+3')),
        ButtonSegment<int>(value: 5, label: Text('+5')),
        ButtonSegment<int>(value: 9, label: Text('+9'))
      ],
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity(horizontal: -1, vertical: -1),
      ),
      selected: <int>{point},
      onSelectionChanged: (Set<int> newSelection) {
        setState(() {
          point = newSelection.first;
        });
        widget.callback(newSelection.first);
      },
    );
  }
}
