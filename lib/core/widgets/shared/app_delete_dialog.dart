import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../common/loaders.dart';

class AppDeleteDialog {
  static Future<void> show({
    required BuildContext context,
    required String itemName,
    required VoidCallback onConfirm,
    String title = 'Confirm Delete',
    String confirmButtonText = 'Yes',
    String cancelButtonText = 'No',
    String successMessage = 'Deleted successfully',
    Color confirmButtonColor = AppColors.error,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Do you really want to delete "$itemName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(cancelButtonText),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
                AppLoaders.successSnackBar(title: successMessage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmButtonColor,
              ),
              child: Text(confirmButtonText),
            ),
          ],
        );
      },
    );
  }
}
