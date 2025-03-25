import 'package:alps2alps_test_task/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.confirmationTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(context.l10n.confirmationText),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(context.l10n.confirmationCancelButtonTitle),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(context.l10n.confirmationConfirmButtonTitle),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
