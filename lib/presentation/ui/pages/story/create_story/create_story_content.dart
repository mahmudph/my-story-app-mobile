/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/presentation/ui/widgets/btn_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/form_field_widget.dart';
import 'package:my_story_app/utils/helper.dart';

class CreateStoryContent extends StatefulWidget {
  const CreateStoryContent({super.key});

  @override
  State<CreateStoryContent> createState() => _CreateStoryContentState();
}

class _CreateStoryContentState extends State<CreateStoryContent> {
  final ValueNotifier<int> selectedcategoryId = ValueNotifier<int>(0);
  final GlobalKey<FormState> createStoryForm = GlobalKey<FormState>();
  late TextEditingController title, description;

  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  void loadCategories() {
    Future.microtask(() {
      final bloc = BlocProvider.of<ListCategoryCubit>(context, listen: false);
      bloc.loadCategories();
    });
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    selectedcategoryId.dispose();
    super.dispose();
  }

  void handleOnCreateStory(CreateStoryCubit bloc) {
    final isValidForm = createStoryForm.currentState?.validate();

    if ((isValidForm ?? false)) {
      /**
       * create story payload
       */
      final createstoryPayload = {
        'title': title.text.trim(),
        'description': description.text.trim(),
        'category_id': selectedcategoryId.value,
        'photo': '',
      };

      bloc.handleCreateStory(createstoryPayload);
      return;
    }

    EasyLoading.showError('invalid create story form');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<CreateStoryCubit>(context, listen: false);
    return BlocListener(
      bloc: bloc,
      listener: (_, state) {
        if (state is CreateStoryLoadingState) {
          EasyLoading.show();
        } else if (state is CreateStorySuccessState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
        } else if (state is CreateStoryFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: createStoryForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CreateStoryCubit, CreateStoryState>(
                builder: (context, state) {
                  String? errorField;
                  if (state is CreateStoryFailureState) {
                    final errorFormField = state.errorFormFields;
                    errorField = getFormErrorMessageByKey(
                      errorFormField,
                      'title',
                    );
                  }
                  return FormFieldWidget(
                    label: "Title",
                    hint: "Enter title",
                    textEditingController: title,
                    errorFormField: errorField,
                  );
                },
              ),
              BlocBuilder<CreateStoryCubit, CreateStoryState>(
                builder: (context, state) {
                  String? errorField;
                  if (state is CreateStoryFailureState) {
                    final errorFormField = state.errorFormFields;
                    errorField = getFormErrorMessageByKey(
                      errorFormField,
                      'description',
                    );
                  }
                  return FormFieldWidget(
                    label: "Description",
                    hint: "Enter descriptions",
                    textEditingController: description,
                    errorFormField: errorField,
                  );
                },
              ),
              SizedBox(
                width: size.width,
                child: BlocBuilder<ListCategoryCubit, ListCategoryState>(
                  bloc: BlocProvider.of<ListCategoryCubit>(context),
                  builder: (_, state) {
                    if (state is ListCategorySuccessState) {
                      return DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        onChanged: (e) => selectedcategoryId.value = e ?? 0,
                        items: state.categories.map((item) {
                          return DropdownMenuItem(
                            value: item.id,
                            child: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: BtnWidget(
                  btnName: "Simpan",
                  onPress: () => handleOnCreateStory(bloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
