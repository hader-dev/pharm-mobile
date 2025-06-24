import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/login/cubit/login_cubit.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              label: 'Email or phone Number',
              controller: BlocProvider.of<LoginCubit>(context).userNameController,
              state: FieldState.normal,
              validationFunc: () {},
            ),
            Gap(AppSizesManager.s4),
            CustomTextField(
              label: 'Password',
              controller: BlocProvider.of<LoginCubit>(context).passwordController,
              onChanged: (value) {},
              isObscure: BlocProvider.of<LoginCubit>(context).isObscured,
              suffixIcon: InkWell(
                  onTap: () => BlocProvider.of<LoginCubit>(context).showPassword(),
                  child: BlocProvider.of<LoginCubit>(context).isObscured
                      ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                      : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
              state: FieldState.normal,
              validationFunc: () {},
            ),
            Gap(AppSizesManager.s12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                PrimaryTextButton(
                  label: "Forgot Password?",
                  onTap: () {},
                  labelColor: AppColors.accent1Shade1,
                ),
              ],
            ),
            Gap(AppSizesManager.s24),
            PrimaryTextButton(
              label: "Login",
              isLoading: state is LoginLoading,
              onTap: () {
                BlocProvider.of<LoginCubit>(context).login(
                  context.read<LoginCubit>().userNameController.text,
                  context.read<LoginCubit>().passwordController.text,
                );
              },
              color: AppColors.accent1Shade1,
            ),
          ],
        );
      },
    );
  }
}
