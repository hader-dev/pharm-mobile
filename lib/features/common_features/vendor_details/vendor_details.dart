import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, MultiBlocProvider, ReadContext, BlocListener;
import 'package:gap/gap.dart' show Gap;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';

import 'package:iconsax/iconsax.dart';

import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../repositories/remote/company/company_repository_impl.dart';
import '../../../repositories/remote/favorite/favorite_repository_impl.dart';
import '../../../repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import '../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/constants.dart';
import '../../../utils/toast_helper.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import '../market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import '../market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'cubit/vendor_details_cubit.dart';

import 'widget/tabs_section.dart';

class VendorDetails extends StatelessWidget {
  final String companyId;
  static final vendorDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const VendorDetails({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                VendorDetailsCubit(companyRepo: CompanyRepository(client: getItInstance.get<INetworkService>()))
                  ..getVendorDetails(companyId),
          ),
          BlocProvider(
            create: (context) => ParaPharmaCubit(
                favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
                scrollController: ScrollController(),
                searchController: TextEditingController(text: ""),
                paraPharmaRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()))
              ..getParaPharmas(companyIdFilter: companyId),
          ),
          BlocProvider(
            create: (context) => MedicineProductsCubit(
                scrollController: ScrollController(),
                favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
                searchController: TextEditingController(text: ""),
                medicineRepository: MedicineCatalogRepository(client: getItInstance.get<INetworkService>()))
              ..getMedicines(companyIdFilter: companyId),
          ),
        ],
        child: BlocListener<VendorDetailsCubit, VendorDetailsState>(
          listener: (context, state) {
            if (state is VendorLiked) {
              getItInstance
                  .get<ToastManager>()
                  .showToast(type: ToastType.success, message: 'Vendor added to your favorites list');
            }
          },
          child: Scaffold(
            key: vendorDetailsScaffoldKey,
            appBar: CustomAppBar(
              bgColor: AppColors.bgWhite,
              topPadding: MediaQuery.of(context).padding.top,
              bottomPadding: MediaQuery.of(context).padding.bottom,
              leading: IconButton(
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                  size: AppSizesManager.iconSize25,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              trailing: [
                BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
                  builder: (context, state) {
                    return PrimaryTextButton(
                        label: "Join",
                        leadingIcon: Iconsax.user_add,
                        labelColor: AppColors.accent1Shade1,
                        onTap: () {
                          context
                              .read<VendorDetailsCubit>()
                              .requestJoinVendorAsClient(context.read<VendorDetailsCubit>().vendorData.id);
                        },
                        isLoading: state is SendingJoinRequest,
                        borderColor: AppColors.accent1Shade1);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: AppSizesManager.p8),
                  child: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
                    builder: (context, state) {
                      return InkWell(
                        child: const Icon(
                          Iconsax.heart,
                          size: AppSizesManager.iconSize20,
                        ),
                        onTap: () {
                          context
                              .read<VendorDetailsCubit>()
                              .likeVendor(context.read<VendorDetailsCubit>().vendorData.id);
                        },
                      );
                    },
                  ),
                ),
              ],
              title: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
                builder: (context, state) {
                  if (state is VendorDetailsLoading) {
                    return Text("Loading...", style: AppTypography.headLine4SemiBoldStyle);
                  }
                  return Row(children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                        image: DecorationImage(
                          image: context.read<VendorDetailsCubit>().vendorData.image == null
                              ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                              : NetworkImage(context.read<VendorDetailsCubit>().vendorData.thumbnailImage),
                        ),
                      ),
                    ),
                    Gap(AppSizesManager.s8),
                    Text(context.read<VendorDetailsCubit>().vendorData.name,
                        style: AppTypography.headLine4SemiBoldStyle)
                  ]);
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
              child: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
                builder: (context, state) {
                  if (state is VendorDetailsLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return VandorDetailsTabBarSection();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
