import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_my_clients.dart';

part 'delegate_clients_state.dart';

class DelegateClientsCubit extends Cubit<DelegateClientsState> {
  final IClientsRepository clientsRepo;
  final ScrollController scrollController;
  final TextEditingController searchController;
  Timer? _debounce;

  DelegateClientsCubit({
    required this.clientsRepo,
    required this.scrollController,
    required this.searchController,
  }) : super(const DeligateClientsInitial()) {
    _onScroll();
  }

  void searchClients([String? text]) => _debounceFunction(() => getClients());

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  Future<void> getClients({int offset = 0}) async {
    try {
      final searchText = searchController.text.trim();

      emit(state.loading(offset: offset));

      final response = await clientsRepo
          .getMyClients(ParamsLoadMyClients(limit: state.limit, offset: state.offSet, searchQuery: searchText));

      emit(state.loaded(
        clients: response.clients,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.clients.length >= response.totalItems,
      ));
    } catch (e) {
      debugPrint("Error loading clients: $e");
      emit(state.failed(
        "Failed to load clients",
      ));
    }
  }

  Future<void> loadMoreAnnouncements() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.limitReached());
        return;
      }

      final offSet = state.offSet + state.limit;
      emit(state.loading(offset: offSet));

      final response = await clientsRepo.getMyClients(ParamsLoadMyClients(
        limit: state.limit,
        offset: offSet,
      ));

      emit(state.loaded(
        clients: response.clients,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.clients.length >= response.totalItems,
      ));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error loading more announcements: $e");
      emit(state.failed(
        "Failed to load more announcements",
      ));
    }
  }

  Future<void> refreshAnnouncements() async {
    emit(state.initial());
    await getClients();
  }

  void _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreAnnouncements();
        } else {
          emit(state.limitReached());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
