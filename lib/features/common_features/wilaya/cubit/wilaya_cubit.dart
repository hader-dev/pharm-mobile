import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'wilaya_state.dart';

class WilayaCubit extends Cubit<WilayaState> {
  final IWilayaRepository wilayaRepository;
  WilayaCubit({required this.wilayaRepository}) : super(WilayaStateInitial());

  void loadWilayas() async {
    try {
      if (state.loadedWilaya) return;
      emit(state.toLoadingWilaya());
      final wilayas =
          (await wilayaRepository.getWilayas(ParamsLoadWilayas())).wilayas;
      emit(state.toLoadedWilaya(
        wilayas: wilayas,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingWilayaError());
    }
  }

  void loadTowns() async {
    try {
      emit(state.toLoadingTowns());

      final towns = (await wilayaRepository.getWilayaTowns(
              ParamsLoadWilayaTowns(
                  locale: state.locale, wilayaId: state.selectedWilaya!.id)))
          .towns;
      emit(state.toLoadedTowns(
        towns: towns,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingTownsError());
    }
  }

  void updateSelectedWilaya(Wilaya? wilaya) {
    if (wilaya != null) {
      loadTowns();
    }
    emit(state.toSelectWilaya(wilaya: wilaya));
  }

  void updateSelectedTown(Town? town) {
    emit(state.toSelectTown(town: town));
  }

  void updateLocale(String locale) {
    emit(state.toInitial(locale: locale));
  }
}
