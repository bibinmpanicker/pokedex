import 'package:flutter/material.dart';

Future<bool> showConfirmDeleteDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String actionButtonName,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(),
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.delete),
                label: Text(actionButtonName),
              ),
            ],
          );
        },
      ) ??
      false; // returns false if dialog is dismissed
}
