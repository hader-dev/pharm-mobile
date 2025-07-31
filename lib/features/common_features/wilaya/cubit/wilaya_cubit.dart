import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'wilaya_state.dart';

class WilayaCubit extends Cubit<WilayaState> {
  late List<Wilaya> wilayas = [];
  late List<Town> towns = [];
  late bool loadedWilaya = false;
  Wilaya? selectedWilaya;
  Town? selectedTown;
  String locale = "en";

  final IWilayaRepository wilayaRepository;
  WilayaCubit({required this.wilayaRepository}) : super(WilayaStateInitial());

  void loadWilayas() async {
    try {
      if (loadedWilaya) return;
      emit(WilayaIsLoading());
      wilayas =
          (await wilayaRepository.getWilayas(ParamsLoadWilayas())).wilayas;
      loadedWilaya = true;
      emit(WilayaLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(WilayaLoadingError());
    }
  }

  void loadTowns() async {
    try {
      emit(TownlsLoading());
      if (selectedWilaya == null) {
        towns = [];
      }
      towns = (await wilayaRepository.getWilayaTowns(ParamsLoadWilayaTowns(
              locale: locale, wilayaId: selectedWilaya!.id)))
          .towns;
      emit(TownLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(TownLoadingError());
    }
  }

  void updateSelectedWilaya(Wilaya? wilaya) {
    selectedWilaya = wilaya;
    if(wilaya != null) {
      loadTowns();
    }
  }

  void updateSelectedTown(Town? town) {
    selectedTown = town;
  }

  void updateLocale(String locale) {
    this.locale = locale;
    loadedWilaya = false;
  }
}
