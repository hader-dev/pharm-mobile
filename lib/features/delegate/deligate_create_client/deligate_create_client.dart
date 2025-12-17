import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/actions/print_credentials.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/cubit/cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/widgets/client_type_selector.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/town.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/wilaya.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';
import 'package:iconsax/iconsax.dart';

class DelegateCreateClientScreen extends StatelessWidget {
  const DelegateCreateClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return SafeArea(
      child: Scaffold(
        appBar: DelegateCreateClientAppBar(translation: translation),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: DelegateCreateClientStateProvider(
                    child: BlocBuilder<DelegateCreateClientCubit, DelegateCreateClientState>(
                      builder: (context, state) {
                        if (state is DeligateClientCreated) {
                          printCredentials(state.email, state.password);
                        }

                        final cubit = BlocProvider.of<DelegateCreateClientCubit>(context);
                        return Form(
                          key: cubit.formKeys,
                          child: Column(
                            children: [
                              const ResponsiveGap.s16(),
                              CustomTextField(
                                label: "${translation.company_name}*",
                                controller: cubit.nameController,
                                state: FieldState.normal,
                                validationFunc: (value) => requiredValidator(value, translation),
                              ),
                              const ResponsiveGap.s8(),
                              CustomTextField(
                                label: "${translation.full_name}*",
                                controller: cubit.fullNameController,
                                state: FieldState.normal,
                                validationFunc: (value) => requiredValidator(value, translation),
                              ),
                              ClientTypeSelector(
                                onChanged: (newValue) {
                                  if (newValue == null) return;
                                  cubit.updateState(
                                    companyType: newValue,
                                  );
                                },
                              ),
                              const ResponsiveGap.s24(),
                              CustomTextField(
                                label: "${translation.email}*",
                                controller: cubit.emailController,
                                state: FieldState.normal,
                                validationFunc: (value) => validateIsEmail(value, translation, true),
                              ),
                              const ResponsiveGap.s8(),
                              WilayaDropdown(
                                isRequired: true,
                              ),
                              const ResponsiveGap.s24(),
                              TownDropdown(
                                  isRequired: true,
                                  validator: (v) => requiredValidator(v?.label, translation),
                                  onChanged: (newValue) {
                                    if (newValue == null) return;
                                    cubit.updateState(
                                      townId: newValue.id,
                                    );
                                  }),
                              const ResponsiveGap.s24(),
                              CustomTextField(
                                label: translation.phone_mobile,
                                controller: cubit.phoneController,
                                state: FieldState.normal,
                                keyBoadType: TextInputType.phone,
                                validationFunc: (value) => validateIsMobileNumber(value, translation),
                              ),
                              CustomTextField(
                                label: translation.full_address,
                                controller: cubit.addressController,
                                state: FieldState.normal,
                                validationFunc: (value) => emptyValidator(value, translation),
                              ),
                              const ResponsiveGap.s16(),
                              BlocBuilder<DelegateCreateClientCubit, DelegateCreateClientState>(
                                buildWhen: (previous, current) =>
                                    current is DeligateClientCreated || previous is DelegateClientCreationLoading,
                                builder: (context, state) {
                                  return PrimaryTextButton(
                                    label: translation.add_client,
                                    leadingIcon: Iconsax.add,
                                    isLoading: state is DelegateClientCreationLoading,
                                    onTap: state is DelegateClientCreationLoading
                                        ? null
                                        : () => BlocProvider.of<DelegateCreateClientCubit>(context).submit(translation),
                                    color: AppColors.accent1Shade1,
                                  );
                                },
                              ),
                              const ResponsiveGap.s16(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
