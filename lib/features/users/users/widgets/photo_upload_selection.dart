import 'dart:io';
import 'package:flutter/material.dart';

class PhotoUploadSection extends StatelessWidget {
  final VoidCallback onUploadPressed;
  final File? selectedImage;

  const PhotoUploadSection({
    super.key,
    required this.onUploadPressed,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Photo',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onUploadPressed,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      selectedImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.person, size: 60),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onUploadPressed,
          icon: const Icon(Icons.cloud_upload),
          label: const Text('Upload photo'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }
}
