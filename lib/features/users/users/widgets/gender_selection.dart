import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  final String selectedGender;
  final Function(String) onGenderChanged;

  const GenderSelection({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: widget.selectedGender,
                onChanged: (String? value) {
                  if (value != null) {
                    widget.onGenderChanged(value);
                  }
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: widget.selectedGender,
                onChanged: (String? value) {
                  if (value != null) {
                    widget.onGenderChanged(value);
                  }
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
