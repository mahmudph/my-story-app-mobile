/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoWidget extends StatelessWidget {
  final String title, message;

  const InfoWidget({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
