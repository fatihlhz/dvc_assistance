import 'package:dvc_assistance/providers/dragon_card_provider.dart';
import 'package:dvc_assistance/widgets/form_dialog_widget.dart';
import 'package:dvc_assistance/widgets/validation_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:dvc_assistance/widgets/dragon_card_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DragonCardProvider>(context, listen: false).getAllCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    DragonCardProvider provider = Provider.of<DragonCardProvider>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.black45,
              height: 1.0,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: Consumer<DragonCardProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final cards = value.cards;
                return ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return DragonCardWidget(data: cards[index], index: index);
                  },
                );
              },
            )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (provider.selectedCardIndex > -1)
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return ValidationDialogWidget(cardContext: context);
                      });
                },
                foregroundColor: colorScheme.primary,
                backgroundColor: colorScheme.surface,
                tooltip: 'Delete',
                child: const Icon(Icons.delete),
              ),
            const SizedBox(
              height: 16.0,
            ),
            if (provider.selectedCardIndex > -1)
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return FormDialogWidget(
                            title: "Edit Dragon",
                            dragonCardData: provider.getSelectedCard());
                      });
                },
                foregroundColor: colorScheme.primary,
                backgroundColor: colorScheme.surface,
                tooltip: 'Edit',
                child: const Icon(Icons.edit),
              ),
            const SizedBox(height: 16.0),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const FormDialogWidget(
                        title: "Add Dragon", dragonCardData: null);
                  },
                );
              },
              foregroundColor: colorScheme.inverseSurface,
              backgroundColor: colorScheme.surface,
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }
}
