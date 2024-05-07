import 'package:dvc_assistance/models/dragon_card_model.dart';
import 'package:dvc_assistance/models/dragon_model.dart';
import 'package:dvc_assistance/models/personality_model.dart';
import 'package:dvc_assistance/providers/dragon_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormDialogWidget extends StatefulWidget {
  final String title;
  final DragonCardModel? dragonCardData;
  const FormDialogWidget(
      {super.key, required this.title, required this.dragonCardData});

  @override
  _FormDialogWidgetState createState() => _FormDialogWidgetState();
}

class _FormDialogWidgetState extends State<FormDialogWidget> {
  String selectedDragon = 'Option 1';
  String selectedBase = 'Option A';
  String selectedTarget = 'Item 1';

  DragonCardModel mithra = DragonCardModel(
      dragonData: DragonModel(
          name: "Mithra",
          personality: "Docile",
          agility: 10,
          strength: 15,
          focus: 5,
          intellect: 25,
          views: 0,
          visit: 0),
      targetPersonality: PersonalityModel(
          name: "Capable",
          agility: 28,
          strength: 28,
          focus: 28,
          intellect: 28,
          views: 1,
          visit: 1));

  @override
  Widget build(BuildContext context) {
    DragonCardProvider provider = Provider.of<DragonCardProvider>(context);
    double colgap = 24;
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownMenu<String>(
            label: const Text("Dragon"),
            width: 220,
            initialSelection: selectedDragon,
            onSelected: (String? value) {
              setState(() {
                selectedDragon = value!;
              });
            },
            requestFocusOnTap: true,
            dropdownMenuEntries:
                ['Option 1', 'Option 2', 'Option 3'].map((String option) {
              return DropdownMenuEntry<String>(
                value: option,
                label: option,
              );
            }).toList(),
          ),
          SizedBox(height: colgap),
          DropdownMenu<String>(
            label: const Text("Base Personality"),
            width: 220,
            initialSelection: selectedBase,
            onSelected: (String? value) {
              setState(() {
                selectedDragon = value!;
              });
            },
            requestFocusOnTap: true,
            dropdownMenuEntries:
                ['Option A', 'Option B', 'Option C'].map((String option) {
              return DropdownMenuEntry<String>(
                value: option,
                label: option,
              );
            }).toList(),
          ),
          SizedBox(height: colgap),
          DropdownMenu<String>(
            label: const Text("Target Personality"),
            width: 220,
            initialSelection: selectedTarget,
            onSelected: (String? value) {
              setState(() {
                selectedDragon = value!;
              });
            },
            requestFocusOnTap: true,
            dropdownMenuEntries:
                ['Item 1', 'Item 2', 'Item 3'].map((String option) {
              return DropdownMenuEntry<String>(
                value: option,
                label: option,
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            print('Save: $selectedDragon, $selectedBase, $selectedTarget');
            if (widget.dragonCardData == null) {
              provider.addCard(mithra);
            }

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
