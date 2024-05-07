import 'package:dvc_assistance/providers/dragon_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidationDialogWidget extends StatefulWidget {
  final BuildContext cardContext;
  const ValidationDialogWidget({super.key, required this.cardContext});

  @override
  _ValidationDialogWidgetState createState() => _ValidationDialogWidgetState();
}

class _ValidationDialogWidgetState extends State<ValidationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Are you sure to delete this card?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<DragonCardProvider>(widget.cardContext, listen: false)
                .deleteCard();
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
