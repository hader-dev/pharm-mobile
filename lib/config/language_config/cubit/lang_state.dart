abstract class LangState {}

class LangInitial extends LangState {}

class LangChanged extends LangState {}

final class LangSettingsSaved extends LangState {}

final class LangSettingsSaveFailed extends LangState {}
