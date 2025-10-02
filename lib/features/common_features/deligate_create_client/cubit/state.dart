part of 'cubit.dart';

abstract class DeligateCreateClientState extends Equatable {
  final String address;
  final String email;
  final String name;
  final String phone;
  final int townId;
  final String fullName;
  final CompanyType companyType;

  const DeligateCreateClientState(
      {required this.address,
      required this.email,
      required this.name,
      required this.fullName,
      required this.phone,
      required this.companyType,
      required this.townId});

  DeligateCreateClientState copyWith(
      {String? address,
      String? email,
      String? fullName,
      String? phone,
      String? name,
      int? townId,
      CompanyType? companyType}) {
    return DeligateClientsInitial(
        address: address ?? this.address,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        fullName: fullName ?? this.fullName,
        townId: townId ?? this.townId,
        companyType: companyType ?? this.companyType);
  }

  DeligateClientsInitial initial({
    String address = '',
    String email = '',
    String fullName = '',
    String phone = "",
    String name = "",
    CompanyType companyType = CompanyType.Pharmacy,
    int townId = 20,
  }) {
    return DeligateClientsInitial(
      name: name,
      email: email,
      address: address,
      fullName: fullName,
      phone: phone,
      townId: townId,
      companyType: companyType,
    );
  }

  ClientsLoadingFailed failed(String message) =>
      ClientsLoadingFailed.fromState(this, message: message);

  DeligateCreateClientLoading loading() =>
      DeligateCreateClientLoading.fromState(this);

  @override
  List<Object?> get props => [
        address,
        email,
        name,
        phone,
        townId,
      ];
}

final class DeligateClientsInitial extends DeligateCreateClientState {
  const DeligateClientsInitial({
    super.address = '',
    super.email = '',
    super.name = '',
    super.phone = '',
    super.townId = 20,
    super.fullName = '',
    super.companyType = CompanyType.Pharmacy,
  });
}

final class DeligateCreateClientLoading extends DeligateCreateClientState {
  DeligateCreateClientLoading.fromState(DeligateCreateClientState state)
      : super(
          address: state.address,
          email: state.email,
          name: state.name,
          phone: state.phone,
          townId: state.townId,
          companyType: state.companyType,
          fullName: state.fullName,
        );
}

final class ClientsLoadingFailed extends DeligateClientsInitial {
  final String message;

  ClientsLoadingFailed.fromState(
    DeligateCreateClientState state, {
    required this.message,
  }) : super(
          address: state.address,
          email: state.email,
          name: state.name,
          phone: state.phone,
          townId: state.townId,
          fullName: state.fullName,
        );

  @override
  List<Object> get props => [address, email, message];
}
