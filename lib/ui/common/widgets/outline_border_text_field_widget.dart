import 'package:flutter/material.dart';

import '../../../theme/typographies.dart';

class OutlineBorderTextFieldWidget extends StatelessWidget {
  const OutlineBorderTextFieldWidget({
    super.key,
    this.label,
    this.hintText,
  });

  final String? label;
  final String? hintText;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null)
            Text(
              label!,
              style: Typo.bMedium14.copyWith(fontSize: 20),
            ),
          const SizedBox(height: 8),
          TextField(
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            cursorColor: const Color(0xFFFFA800),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEDEDED),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFFF0000),
                ),
              ),
            ),
          ),
        ],
      );
}
