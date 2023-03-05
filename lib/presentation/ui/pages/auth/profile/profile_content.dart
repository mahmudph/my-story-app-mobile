/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/bloc/auth/user/user_cubit.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserCubit>(context, listen: false);
    return BlocConsumer<UserCubit, UserState>(
      bloc: bloc,
      listener: (_, state) {
        if (state is UserLoadingState) {
          EasyLoading.show();
        } else if (state is UserSuccessState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
        } else if (state is UserFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
        }
      },
      builder: (_, state) {
        if (state is UserLoadingState) {
        } else if (state is UserSuccessState) {
        } else if (state is UserFailureState) {}
        return Container();
      },
    );
  }
}
