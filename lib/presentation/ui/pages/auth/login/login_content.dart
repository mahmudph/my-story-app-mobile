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
import 'package:my_story_app/presentation/bloc/auth/login/login_cubit.dart';
import 'package:my_story_app/utils/helper.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  late TextEditingController email, password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void handleUserLogin(LoginCubit bloc) async {
    final isValidFrom = loginForm.currentState?.validate() ?? false;

    if (isValidFrom) {
      return bloc.handleUserLogin(
        {'email': email.text.trim(), 'password': password.text.trim()},
      );
    }

    EasyLoading.showError("invalid form, pelase make sure all field is valid");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<LoginCubit>(context, listen: false);

    return BlocListener<LoginCubit, LoginState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          EasyLoading.show();
        } else if (state is LoginSuccessState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();

          /**
           * when login state is success
           * then show info success and then navigate to the list of story
           */

          EasyLoading.showSuccess("Login Success");

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.home,
            (route) => false,
          );
        } else if (state is LoginFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();

          /**
           * show error message
           */
          EasyLoading.showError(
            state.messages,
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: false,
          );
        }
      },
      child: Form(
        key: loginForm,
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
            BlocBuilder<LoginCubit, LoginState>(
              bloc: bloc,
              builder: (_, state) {
                String? errorField;
                if (state is LoginFailureState) {
                  final erorrFormField = state.errorFormFields;
                  errorField = getFormErrorMessageByKey(
                    erorrFormField,
                    'email',
                  );
                }
                return FormFieldWidget(
                  hint: "Enter email address",
                  label: "Email",
                  textEditingController: email,
                  errorFormField: errorField,
                );
              },
            ),
            BlocBuilder<LoginCubit, LoginState>(
              bloc: bloc,
              builder: (_, state) {
                String? errorField;
                if (state is LoginFailureState) {
                  final erorrFormField = state.errorFormFields;
                  errorField = getFormErrorMessageByKey(
                    erorrFormField,
                    'password',
                  );
                }
                return FormFieldWidget(
                  hint: "Enter password",
                  label: "Password",
                  textEditingController: password,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  errorFormField: errorField,
                );
              },
            ),
            BtnWidget(
              btnName: "LOGIN",
              onPress: () => handleUserLogin(bloc),
            ),
            BtnWidget(
              btnName: "REGISTER",
              btnColor: Colors.green,
              onPress: () => Navigator.pushNamed(context, RouteName.register),
            ),
          ],
        ),
      ),
    );
  }
}
