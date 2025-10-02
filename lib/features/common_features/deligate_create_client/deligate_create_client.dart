import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_client/cubit/cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_client/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_client/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_client/widgets/client_type_selector.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/town.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/wilaya.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class DeligateCreateClientScreen extends StatelessWidget {
  const DeligateCreateClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return SafeArea(
      child: Scaffold(
        appBar: DeligateCreateClientAppbar(translation: translation),
        body: Padding(
          padding: EdgeInsets.all(AppSizesManager.p8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: DeligateCreateClientStateProvider(
              child: BlocBuilder<DeligateCreateClientCubit,
                  DeligateCreateClientState>(
                builder: (context, state) {
                  final cubit =
                      BlocProvider.of<DeligateCreateClientCubit>(context);
                  return Form(
                    key: cubit.formKeys,
                    child: Column(
                      children: [
                        const ResponsiveGap.s16(),
                        CustomTextField(
                          label: "${translation.company_name}*",
                          controller: cubit.nameController,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              requiredValidator(value, translation),
                        ),
                        ClientTypeSelector(
                          onChanged: (newValue) {
                            if (newValue == null) return;
                            cubit.updateState(
                              companyType: newValue,
                            );
                          },
                        ),
                        const ResponsiveGap.s12(),
                        CustomTextField(
                          label: "${translation.full_name}*",
                          controller: cubit.fullNameController,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              requiredValidator(value, translation),
                        ),
                        CustomTextField(
                          label: "${translation.email}*",
                          controller: cubit.emailController,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              validateIsEmail(value, translation, true),
                        ),
                        CustomTextField(
                          label: translation.phone_mobile,
                          controller: cubit.phoneController,
                          state: FieldState.normal,
                          keyBoadType: TextInputType.phone,
                          validationFunc: (value) =>
                              validateIsMobileNumber(value, translation),
                        ),
                        CustomTextField(
                          label: translation.full_address,
                          controller: cubit.addressController,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              emptyValidator(value, translation),
                        ),
                        WilayaDropdown(),
                        TownDropdown(
                            isRequired: true,
                            validator: (v) =>
                                requiredValidator(v?.label, translation),
                            onChanged: (newValue) {
                              if (newValue == null) return;
                              cubit.updateState(
                                townId: newValue.id,
                              );
                            }),
                        const ResponsiveGap.s16(),
                        PrimaryTextButton(
                          label: translation.add_client,
                          onTap: () => cubit.submit(translation),
                          color: AppColors.accent1Shade1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
