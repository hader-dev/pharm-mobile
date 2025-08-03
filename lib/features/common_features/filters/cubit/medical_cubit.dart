import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
part 'medical_state.dart';

class MedicalFiltersCubit extends Cubit<MedicalFiltersState> {


  MedicalFiltersCubit() : super(MedicalFiltersStateInitial());

  void loadMedicalFilterss() async {
    try {
      emit(MedicalFiltersIsLoading());
     
      emit(MedicalFiltersLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicalFiltersLoadingError());
    }
  }


}
