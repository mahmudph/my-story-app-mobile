/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';

class StoryItemWidget extends StatelessWidget {
  final StoryEntity story;
  final VoidCallback onPress;

  const StoryItemWidget({
    super.key,
    required this.story,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: SizedBox(
        width: size.width * 0.3,
        height: size.width * 0.3,
        child: Image.network(
          "${dotenv.env['BASE_URL']}${story.photo}",
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        "${story.title} - ${story.category.name}",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        story.description,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      dense: true,
      onTap: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        size: 24,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
    );
  }
}
