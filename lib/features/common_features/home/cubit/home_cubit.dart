import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PromotionRepository announcementsRepo;
  HomeCubit({required this.announcementsRepo}) : super(HomeInitial());

  Future<void> getPromotions({int limit = 10}) async {
    emit(state.toLoading());
    final announcements =
        (await announcementsRepo.getPromotions(limit: limit)).announcements;
    emit(state.toLoadingSuccess(announcements: announcements));
  }
}
