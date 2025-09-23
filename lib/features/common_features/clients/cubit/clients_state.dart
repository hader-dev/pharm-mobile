part of 'clients_cubit.dart';

abstract class DeligateClientsState extends Equatable {
  final List<DeligateClient> clients;
  final bool hasReachedMax;
  final int totalItemsCount;
  final int offSet;
  final int limit;

  const DeligateClientsState(
      {required this.clients,
      required this.hasReachedMax,
      required this.totalItemsCount,
      required this.offSet,
      required this.limit});

  DeligateClientsState copyWith({
    List<DeligateClient>? clients,
    bool? hasReachedMax,
    int? totalItemsCount,
    int? offSet,
    int? limit,
  }) {
    return DeligateClientsInitial(
      clients: clients ?? this.clients,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      offSet: offSet ?? this.offSet,
      limit: limit ?? this.limit,
    );
  }

  DeligateClientsInitial initial({
    List<DeligateClient> clients = const [],
    bool hasReachedMax = false,
    int totalItemsCount = 0,
    int offSet = 0,
    int limit = 20,
  }) {
    return DeligateClientsInitial(
      clients: clients,
      hasReachedMax: hasReachedMax,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      limit: limit,
    );
  }

  ClientsLoading loading({int? offset}) =>
      ClientsLoading.fromState(copyWith(offSet: offset ?? offSet));

  ClientsLoaded loaded({
    List<DeligateClient>? clients,
    bool? hasReachedMax,
    int? totalItemsCount,
  }) =>
      ClientsLoaded.fromState(
        copyWith(
          clients: clients ?? this.clients,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          totalItemsCount: totalItemsCount ?? this.totalItemsCount,
        ),
      );

  ClientsLoadLimitReached limitReached() =>
      ClientsLoadLimitReached.fromState(this);

  ClientsLoadingFailed failed(String message) =>
      ClientsLoadingFailed.fromState(this, message: message);

  @override
  List<Object?> get props => [
        clients,
        hasReachedMax,
        totalItemsCount,
        offSet,
        limit,
      ];
}

final class DeligateClientsInitial extends DeligateClientsState {
  const DeligateClientsInitial({
    super.clients = const [],
    super.hasReachedMax = false,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.limit = 20,
  });
}

final class ClientsLoading extends DeligateClientsState {
  ClientsLoading.fromState(DeligateClientsState state)
      : super(
          clients: state.clients,
          hasReachedMax: state.hasReachedMax,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );
}

final class ClientsLoaded extends DeligateClientsState {
  ClientsLoaded.fromState(DeligateClientsState state)
      : super(
          clients: state.clients,
          hasReachedMax: state.hasReachedMax,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );
}

final class ClientsLoadLimitReached extends DeligateClientsState {
  ClientsLoadLimitReached.fromState(DeligateClientsState state)
      : super(
          clients: state.clients,
          hasReachedMax: true,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );
}

final class ClientsLoadingFailed extends DeligateClientsState {
  final String message;

  ClientsLoadingFailed.fromState(
    DeligateClientsState state, {
    required this.message,
  }) : super(
          clients: state.clients,
          hasReachedMax: state.hasReachedMax,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );

  @override
  List<Object> get props => [clients, hasReachedMax, message];
}
