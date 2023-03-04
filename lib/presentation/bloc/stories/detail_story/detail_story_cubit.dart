import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';

part 'detail_story_state.dart';

class DetailStoryCubit extends Cubit<DetailStoryState> {
  DetailStoryCubit() : super(DetailStoryInitial());
}
