import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/category_entity.dart';
import 'package:my_story_app/domain/usecase/story/get_category_usecase.dart';

part 'list_category_state.dart';

class ListCategoryCubit extends Cubit<ListCategoryState> {
  final GetCategoryUsecase getCategoryUsecase;

  ListCategoryCubit({
    required this.getCategoryUsecase,
  }) : super(ListCategoryInitial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final result = await getCategoryUsecase.invoke();

    result.fold(
      (failure) => emit(ListCategoryFailureState(message: failure.message)),
      (data) => emit(ListCategorySuccessState(categories: data)),
    );
  }
}
