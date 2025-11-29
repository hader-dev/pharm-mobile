import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/providers.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/widget/appbar.dart';

import 'cubit/vendor_details_cubit.dart';
import 'widget/tabs_section.dart';

class VendorDetails extends StatelessWidget {
  final String companyId;
  static final vendorDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const VendorDetails({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return VendorDetailsProvider(
      companyId: companyId,
      child: Scaffold(
        appBar: VendorDetailsAppBar(),
        key: vendorDetailsScaffoldKey,
        body: SafeArea(
          child: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
            builder: (context, state) {
              if (state is VendorDetailsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return VendorDetailsTabBarSection(
                companyId: companyId,
              );
            },
          ),
        ),
      ),
    );
  }
}
