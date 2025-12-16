import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart'
    show getFocusedBorderColor, getEnabledBorderColor;
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart' show CustomTextField;
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors;
import '../../../../../utils/enums.dart';
import '../cubit/para_pharm_filters_cubit.dart'
    show
        ParaPharmFiltersCubit,
        ParaPharmFiltersState,
        ParaPharmFiltersBrandSearchLoaded,
        ParaPharmFiltersBrandSearchLoading,
        ParaPharmFiltersBrandSearchLoadingFailed;

class BrandSearchFilter extends StatefulWidget {
  const BrandSearchFilter({super.key});

  @override
  State<BrandSearchFilter> createState() => _BrandSearchFilterState();
}

class _BrandSearchFilterState extends State<BrandSearchFilter> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textFieldKey = GlobalKey();

  double _textFieldHeight = 0;
  double _textFieldWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _textFieldHeight = renderBox.size.height;
          _textFieldWidth = renderBox.size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      label: "${context.translation!.brand}: ",
      bgColor: AppColors.bgWhite,
      value: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (_) {
          return CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(-15, _textFieldHeight - 25),
            showWhenUnlinked: false,
            child: Column(
              children: [
                Container(
                    width: _textFieldWidth,
                    decoration: BoxDecoration(
                      color: AppColors.bgWhite,
                      border: Border.all(color: AppColors.bgDisabled),
                      borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                    ),
                    padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
                    child: BlocBuilder<ParaPharmFiltersCubit, ParaPharmFiltersState>(
                      builder: (context, state) {
                        if (state is ParaPharmFiltersBrandSearchLoading) {
                          return const Center(
                              child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
                        }
                        if (state is ParaPharmFiltersBrandSearchLoaded &&
                            context.read<ParaPharmFiltersCubit>().brands.isEmpty) {
                          return Center(
                              child: Text("no brands found", style: context.responsiveTextTheme.current.bodySmall));
                        }
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 160),
                          child: Scrollbar(
                            child: ListView(
                              shrinkWrap: true,
                              children: context
                                  .read<ParaPharmFiltersCubit>()
                                  .brands
                                  .map((e) => InkWell(
                                        onTap: () {
                                          context.read<ParaPharmFiltersCubit>().changeFilters(
                                              context.read<ParaPharmFiltersCubit>().tempFilters.copyWith(brand: e));
                                          context.read<ParaPharmFiltersCubit>().brandSearchController.text = e.name;
                                          _controller.hide();
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p8),
                                          child: Row(
                                            children: [
                                              Text(
                                                e.name,
                                                style: context.responsiveTextTheme.current.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          );
        },
        child: CompositedTransformTarget(
          link: _layerLink,
          key: _textFieldKey,
          child: CustomTextField(
            controller: context.read<ParaPharmFiltersCubit>().brandSearchController,
            suffixIcon: context.watch<ParaPharmFiltersCubit>().brandSearchController.text.isEmpty
                ? null
                : InkWell(
                    onTap: () {
                      context.read<ParaPharmFiltersCubit>().brandSearchController.text = '';
                      context.read<ParaPharmFiltersCubit>().searchBrands(searchValue: '');
                      context.read<ParaPharmFiltersCubit>().changeFilters(
                            context.read<ParaPharmFiltersCubit>().tempFilters.copyWith(brand: null),
                          );
                      _controller.hide();
                    },
                    child: Icon(
                      Icons.close,
                      size: context.responsiveAppSizeTheme.current.iconSize20,
                      color: Colors.grey,
                    ),
                  ),
            hintText: context.translation!.search_select_brand,
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                _controller.show();
              } else {
                _controller.hide();
              }
              context.read<ParaPharmFiltersCubit>().searchBrands(searchValue: value!.isEmpty ? null : value);
            },
          ),
        ),
      ),
    );
  }
}
