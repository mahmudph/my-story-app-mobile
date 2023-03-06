/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldWidget extends StatelessWidget {
  final bool isTextArea;
  final String label, hint;
  final String? errorFormField;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController textEditingController;

  const FormFieldWidget({
    super.key,
    this.errorFormField,
    this.isTextArea = false,
    required this.label,
    required this.hint,
    required this.textEditingController,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              maxLines: isTextArea ? 3 : 1,
              keyboardType: keyboardType,
              controller: textEditingController,
              textInputAction: textInputAction,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (e) =>
                  e == null || e.isEmpty ? '$label is invalid' : null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8,
                ),
                prefix: const Padding(padding: EdgeInsets.only(left: 12)),
                label: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1,
                    color: errorFormField == null
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
          if (errorFormField != null)
            Text(
              errorFormField!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }
}
