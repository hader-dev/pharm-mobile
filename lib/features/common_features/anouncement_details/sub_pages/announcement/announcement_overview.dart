import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';

class AnnouncementOverviewPage extends StatelessWidget {
  const AnnouncementOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<AnnouncementCubit>().loadAnnouncement(),
      child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
        final cubit = context.read<AnnouncementCubit>();
      
        if (state is AnnouncementIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
      
        if (cubit.announcement == null || cubit.announcement?.content == "") {
          return const Center(child: EmptyListWidget());
        }
        return Center(
            child: Markdown(
          data: cubit.announcement?.content ?? "",
        ));
      }),
    );
  }
}
