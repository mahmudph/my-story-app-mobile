/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/ui/pages/home/bottom_menu_util.dart';
import 'package:my_story_app/presentation/ui/widgets/btn_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/form_field_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/pick_image_widget.dart';
import 'package:my_story_app/utils/helper.dart';
import 'package:my_story_app/utils/injectable.dart';

class CreateStoryContent extends StatefulWidget {
  const CreateStoryContent({super.key});

  @override
  State<CreateStoryContent> createState() => _CreateStoryContentState();
}

class _CreateStoryContentState extends State<CreateStoryContent> {
  final ValueNotifier<int> selectedcategoryId = ValueNotifier<int>(0);
  final GlobalKey<FormState> createStoryForm = GlobalKey<FormState>();
  final ValueNotifier<XFile?> selectedImage = ValueNotifier<XFile?>(null);

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
    final isValidPhoto = selectedImage.value != null;

    if ((isValidForm ?? false) && isValidPhoto) {
      /**
       * create story payload
       */
      final createstoryPayload = {
        'title': title.text.trim(),
        'description': description.text.trim(),
        'category_id': selectedcategoryId.value.toInt(),
      };

      final storyPhoto = File(selectedImage.value!.path);
      bloc.handleCreateStory(
        createstoryPayload,
        storyPhoto,
      );
      return;
    }

    EasyLoading.showError('invalid create story form');
  }

  void pickImageFromSource(bool isFromCamera) async {
    try {
      final picker = Injectable.getIt<ImagePicker>();

      selectedImage.value = await picker.pickImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 60,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: Text(
                "Pick from Galery",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              onTap: () {
                pickImageFromSource(false);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(
                "Pick from Camera",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              onTap: () {
                pickImageFromSource(true);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void resetFormField(BuildContext context) {
    title.text = '';
    description.text = '';
    selectedImage.value = null;
    createStoryForm.currentState?.reset();
    /**
     * set to the home screen
     */
    final bloc = BlocProvider.of<ListStoryCubit>(context, listen: false);
    bloc.loadStoriesList().then((_) {
      BottomMenuUtil.of(context).setActiveMenu(0);
    });
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
          EasyLoading.showSuccess("Success to create new story");
          resetFormField(context);
        } else if (state is CreateStoryFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
      },
      child: BlocListener<ListCategoryCubit, ListCategoryState>(
        bloc: BlocProvider.of<ListCategoryCubit>(context, listen: false),
        listener: (context, state) {
          if (state is ListCategoryLoadingState) {
            EasyLoading.show();
          } else if (state is ListCategorySuccessState) {
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ListCategoryFailureState) {
            if (EasyLoading.isShow) EasyLoading.dismiss();
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
                      isTextArea: true,
                      label: "Description",
                      hint: "Enter description",
                      textEditingController: description,
                      errorFormField: errorField,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
                    width: size.width,
                    child: BlocBuilder<ListCategoryCubit, ListCategoryState>(
                      bloc: BlocProvider.of<ListCategoryCubit>(context),
                      builder: (_, state) {
                        if (state is ListCategorySuccessState) {
                          return DropdownButtonFormField(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              label: Text(
                                "Category",
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              hintText: "Select category",
                              alignLabelWithHint: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                ),
                ValueListenableBuilder<XFile?>(
                  valueListenable: selectedImage,
                  builder: (_, photo, child) {
                    final hint = photo?.path.split('/').last ?? 'Select Photo';
                    return PickImageWidget(
                      hint: hint,
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        showActions(context);
                      },
                    );
                  },
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
      ),
    );
  }
}
