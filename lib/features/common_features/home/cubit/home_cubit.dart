import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  List<AnnouncementModel> announcements = <AnnouncementModel>[];
  final PromotionRepository announcementsRepo;
  HomeCubit({required this.announcementsRepo}) : super(HomeInitial());

  Future<void> getPromotions() async {
    emit(PromotionLoading());
    announcements = (await announcementsRepo.getPromotions()).announcements;
    emit(PromotionLoadingSuccess());
  }

}
