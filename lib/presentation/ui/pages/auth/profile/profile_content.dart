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
import 'package:my_story_app/presentation/bloc/auth/user/user_cubit.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/presentation/ui/widgets/btn_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/content_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/info_widget.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        } else if (state is UserLogoutStatusState) {
          EasyLoading.showInfo(state.message);
          if (state.isSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.login,
              (route) => false,
            );
          }
        }
      },
      buildWhen: (_, state) {
        return state is! UserLogoutStatusState && state is! UserLoadingState;
      },
      builder: (_, state) {
        if (state is UserSuccessState) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "User Information",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Name: ${state.user.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Name: ${state.user.email}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const ContentWidget(
                  text:
                      "Eiusmod nisi velit consequat Lorem pariatur cillum consectetur enim adipisicing ullamco. Et ut quis ipsum officia tempor nulla non non excepteur eiusmod laboris nisi laboris irure. Nulla excepteur eiusmod culpa velit. Ex deserunt ipsum dolor ullamco magna. Minim mollit non Lorem non Lorem pariatur reprehenderit voluptate. Voluptate veniam excepteur eu fugiat nulla Lorem anim labore esse cupidatat non duis.",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: BtnWidget(
                    btnName: "LOGOUT",
                    btnColor: Colors.red,
                    onPress: bloc.handleOnUserLogout,
                  ),
                )
              ],
            ),
          );
        } else if (state is UserFailureState) {
          return const InfoWidget(
            title: "Process failure",
            message: "Failed to get profile data",
          );
        }
        return Container();
      },
    );
  }
}
