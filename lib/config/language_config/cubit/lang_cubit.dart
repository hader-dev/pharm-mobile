import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/language_config/language.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

import 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  late String appLang;
  LangCubit() : super(LangInitial());
  void initLanguage() {
    appLang = LanguageHelper.getCurrentLanguage();
    emit(LangInitial());
  }

  Future<void> changeLang(String langCode) async {
    appLang = langCode;
    await LanguageHelper.setCurrentLanguage(langCode);
    emit(LangChanged());
  }

  Future<void> saveLangSettings() async {
    try {
      await LanguageHelper.setCurrentLanguage(appLang);
      emit(LangSettingsSaved());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(LangSettingsSaveFailed());
    }
  }
}
