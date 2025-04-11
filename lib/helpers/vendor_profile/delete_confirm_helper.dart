import 'package:flutter/material.dart';

void deleteConfirmationHelepr(
    {required BuildContext context,
    required String productId,
    required String productName,
    required Future<void> Function(String, BuildContext) deleteConfirm}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Product'),
      content: Text('Are you sure you want to delete "$productName"?'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            deleteConfirm(productId, context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
