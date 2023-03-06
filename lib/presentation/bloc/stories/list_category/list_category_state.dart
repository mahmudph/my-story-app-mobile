part of 'list_category_cubit.dart';

abstract class ListCategoryState extends Equatable {
  const ListCategoryState();

  @override
  List<Object> get props => [];
}

class ListCategoryInitial extends ListCategoryState {}

class ListCategoryLoadingState extends ListCategoryState {}

class ListCategorySuccessState extends ListCategoryState {
  final List<CategoryEntity> categories;

  const ListCategorySuccessState({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class ListCategoryFailureState extends ListCategoryState {
  final String message;

  const ListCategoryFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
