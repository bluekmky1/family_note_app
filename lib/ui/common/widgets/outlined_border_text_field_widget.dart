import 'package:flutter/material.dart';

import '../../../theme/typographies.dart';

class OutlinedBorderTextFieldWidget extends StatelessWidget {
  const OutlinedBorderTextFieldWidget({
    required this.errorText,
    this.onChanged,
    super.key,
    this.label,
    this.hintText,
    this.obscureText,
  });

  final String? label;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String errorText;
  final bool? obscureText;

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
            obscureText: obscureText ?? false,
            onChanged: onChanged,
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
              error: errorText.isEmpty
                  ? null
                  : Text(
                      errorText,
                      style: Typo.bMedium14.copyWith(
                        color: const Color(0xFFFF0000),
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
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFFF0000),
                ),
              ),
              focusColor: Colors.transparent,
            ),
          ),
        ],
      );
}
