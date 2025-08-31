import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => context.read<AnnouncementCubit>().loadAnnouncement(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<AnnouncementCubit>(context);
                  final medicines = cubit.medicines;
      
                  if (state is AnnouncementIsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
      
                  if (medicines.isEmpty) {
                    return const Center(child: EmptyListWidget());
                  }
      
                  final bool isLoadingMore = state is AnnouncementIsLoading;
      
                  return RefreshIndicator(
                    onRefresh: () => cubit.loadAnnouncement(),
                    child: ListView.builder(
                      controller: cubit.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: medicines.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < medicines.length) {
                          final medicine = medicines[index];
                          return MedicineWidget2(
                            hideLikeButton: false,
                            medicineData: medicine,
                            isLiked: medicine.isLiked,
                            onLikeTapped: () {
                              final id = medicine.id;
                              medicine.isLiked
                                  ? cubit.unlikeMedicinesCatalog(id)
                                  : cubit.likeMedicinesCatalog(id);
                            },
                          );
                        } else {
                          if (isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
