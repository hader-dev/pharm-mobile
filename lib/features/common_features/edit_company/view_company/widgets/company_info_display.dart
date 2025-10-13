import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CompanyInfoDisplay extends StatelessWidget {
  const CompanyInfoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCompanyCubit, EditCompanyState>(
      builder: (context, state) {
        final company = state.companyData;

        if (company.id.isEmpty) {
          return Center(
              child: Text(context.translation!.no_company_data_available));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              context,
              title: context.translation!.general_info_title,
              children: [
                _buildInfoColumn(
                    context, context.translation!.company_name, company.name),
                _buildInfoColumn(
                    context,
                    context.translation!.email,
                    company.email ??
                        context.translation!.feedback_not_provided),
                _buildInfoColumn(
                    context,
                    context.translation!.full_address,
                    company.address ??
                        context.translation!.feedback_not_provided),
                _buildInfoColumn(
                    context,
                    context.translation!.phone_mobile,
                    company.phone ??
                        context.translation!.feedback_not_provided),
                if (company.phone2 != null && company.phone2!.isNotEmpty)
                  _buildInfoColumn(
                      context, context.translation!.phone_2, company.phone2!),
                if (company.fax != null && company.fax!.isNotEmpty)
                  _buildInfoColumn(
                      context, context.translation!.fax, company.fax!),
                if (company.website != null && company.website!.isNotEmpty)
                  _buildInfoColumn(
                      context, context.translation!.website, company.website!),
              ],
            ),
            const ResponsiveGap.s16(),
            if (company.description != null && company.description!.isNotEmpty)
              _buildInfoCard(
                context,
                title: context.translation!.description,
                children: [
                  Text(
                    company.description!,
                    style: context.responsiveTextTheme.current.body1Regular
                        .copyWith(
                      color: TextColors.primary.color,
                    ),
                  ),
                ],
              ),
            const ResponsiveGap.s16(),
            if (_hasLegalInfo(company))
              _buildInfoCard(
                context,
                title: context.translation!.legal_info_title,
                children: [
                  if (company.rcNumber != null && company.rcNumber!.isNotEmpty)
                    _buildInfoColumn(context, context.translation!.rc_number,
                        company.rcNumber!),
                  if (company.nisNumber != null &&
                      company.nisNumber!.isNotEmpty)
                    _buildInfoColumn(context, context.translation!.nis_number,
                        company.nisNumber!),
                  if (company.aiNumber != null && company.aiNumber!.isNotEmpty)
                    _buildInfoColumn(context, context.translation!.ai_number,
                        company.aiNumber!),
                  if (company.fiscalId != null && company.fiscalId!.isNotEmpty)
                    _buildInfoColumn(context, context.translation!.fiscal_id,
                        company.fiscalId!),
                  if (company.bankAccount != null &&
                      company.bankAccount!.isNotEmpty)
                    _buildInfoColumn(context, context.translation!.bank_account,
                        company.bankAccount!),
                ],
              ),
          ],
        );
      },
    );
  }

  bool _hasLegalInfo(Company company) {
    return (company.rcNumber != null && company.rcNumber!.isNotEmpty) ||
        (company.nisNumber != null && company.nisNumber!.isNotEmpty) ||
        (company.aiNumber != null && company.aiNumber!.isNotEmpty) ||
        (company.fiscalId != null && company.fiscalId!.isNotEmpty) ||
        (company.bankAccount != null && company.bankAccount!.isNotEmpty);
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizesManager.p16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        border: Border.all(color: AppColors.bgDarken2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(150),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.responsiveTextTheme.current.headLine4SemiBold,
          ),
          const ResponsiveGap.s12(),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizesManager.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const ResponsiveGap.s4(),
          Text(
            value,
            style: context.responsiveTextTheme.current.body1Regular.copyWith(
              color: TextColors.primary.color,
            ),
          ),
        ],
      ),
    );
  }
}
