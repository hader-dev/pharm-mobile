part of 'para_pharma_cubit.dart';

sealed class ParaPharmaState {}

final class ParaPharmaInitial extends ParaPharmaState {}

// Getting the list of medicine products states

final class ParaPharmaProductsLoading extends ParaPharmaInitial {}

final class LoadingMoreParaPharma extends ParaPharmaInitial {}

final class ParaPharmaProductsLoaded extends ParaPharmaInitial {}

final class ParaPharmaProductsLoadingFailed extends ParaPharmaInitial {}

//Search Limit Reached State :
final class ParaPharmasLoadLimitReached extends ParaPharmaInitial {}

final class ParaPharmaSearchFilterChanged extends ParaPharmaInitial {}

final class ParaPharmaLiked extends ParaPharmaInitial {
  String paraPharmaId;

  ParaPharmaLiked({required this.paraPharmaId});
}

final class ParaPharmaLikeFailed extends ParaPharmaInitial {
  String paraPharmaId;

  ParaPharmaLikeFailed({required this.paraPharmaId});
}
