/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/presentation/ui/widgets/btn_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/form_field_widget.dart';
import 'package:my_story_app/presentation/bloc/auth/register/register_cubit.dart';
import 'package:my_story_app/utils/helper.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final GlobalKey<FormState> registerForm = GlobalKey<FormState>();
  late TextEditingController name, email, pwd, pwdConfirmation;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    pwd = TextEditingController();
    pwdConfirmation = TextEditingController();
  }

  @override
  void dispose() {
    pwd.dispose();
    name.dispose();
    email.dispose();
    pwdConfirmation.dispose();
    super.dispose();
  }

  void handleUserRegister(RegisterCubit bloc) async {
    final isValidForm = registerForm.currentState?.validate() ?? false;

    if (isValidForm) {
      /**
       * do register process
       */
      return bloc.handleUserRegister(
        {
          'name': name.text.trim(),
          'email': email.text.trim(),
          'password': pwd.text.trim(),
          'password_confirmation': pwdConfirmation.text.trim(),
        },
      );
    }

    EasyLoading.showError(
      'please make sure all register field have valid value',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top + kToolbarHeight;
    final bloc = BlocProvider.of<RegisterCubit>(context, listen: false);

    return BlocListener<RegisterCubit, RegisterState>(
      bloc: bloc,
      listener: (_, state) {
        if (state is RegisterLoadingState) {
          EasyLoading.show();
        } else if (state is RegisterSuccessState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          EasyLoading.showSuccess("Login Success");

          /**
           * navigate to login screen
           */
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.login,
            (route) => false,
          );
        } else if (state is RegisterFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          EasyLoading.showError(state.messaage);
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: size.height - paddingTop,
          child: Form(
            key: registerForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: bloc,
                  builder: (_, state) {
                    String? errorField;
                    if (state is RegisterFailureState) {
                      final errrorFormField = state.errorFormField;
                      errorField = getFormErrorMessageByKey(
                        errrorFormField,
                        'name',
                      );
                    }
                    return FormFieldWidget(
                      label: "Name",
                      hint: "Enter name",
                      textEditingController: name,
                      keyboardType: TextInputType.name,
                      errorFormField: errorField,
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: bloc,
                  builder: (_, state) {
                    String? errorField;
                    if (state is RegisterFailureState) {
                      final errrorFormField = state.errorFormField;
                      errorField = getFormErrorMessageByKey(
                        errrorFormField,
                        'email',
                      );
                    }
                    return FormFieldWidget(
                      label: "Email address",
                      hint: "Enter email address",
                      textEditingController: email,
                      keyboardType: TextInputType.emailAddress,
                      errorFormField: errorField,
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: bloc,
                  builder: (_, state) {
                    String? errorField;
                    if (state is RegisterFailureState) {
                      final errrorFormField = state.errorFormField;
                      errorField = getFormErrorMessageByKey(
                        errrorFormField,
                        'password',
                      );
                    }
                    return FormFieldWidget(
                      label: "Password",
                      hint: "Enter password",
                      textEditingController: pwd,
                      keyboardType: TextInputType.visiblePassword,
                      errorFormField: errorField,
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  bloc: bloc,
                  builder: (_, state) {
                    String? errorField;
                    if (state is RegisterFailureState) {
                      final errrorFormField = state.errorFormField;
                      errorField = getFormErrorMessageByKey(
                        errrorFormField,
                        'password_confirmation',
                      );
                    }
                    return FormFieldWidget(
                      label: "Password confirmation",
                      hint: "Enter password confirmation",
                      textEditingController: pwdConfirmation,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      errorFormField: errorField,
                    );
                  },
                ),
                BtnWidget(
                  btnName: "Register",
                  onPress: () => handleUserRegister(bloc),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
