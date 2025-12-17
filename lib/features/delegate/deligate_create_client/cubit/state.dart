part of 'cubit.dart';

class DelegateCreateClientState extends Equatable {
  final String address;
  final String email;
  final String name;
  final String phone;
  final int townId;
  final String fullName;
  final CompanyType companyType;

  const DelegateCreateClientState(
      {required this.address,
      required this.email,
      required this.name,
      required this.fullName,
      required this.phone,
      required this.companyType,
      required this.townId});

  DelegateCreateClientState copyWith(
      {String? address,
      String? email,
      String? password,
      String? fullName,
      String? phone,
      String? name,
      int? townId,
      CompanyType? companyType}) {
    return DelegateCreateClientState(
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

  ClientsLoadingFailed failed(String message) => ClientsLoadingFailed.fromState(this, message: message);

  DeligateCreateClientLoading loading() => DeligateCreateClientLoading.fromState(this);
  DelegateClientCreationLoading creationLoading() => DelegateClientCreationLoading.fromState(this);

  DeligateClientCreated created({required String password, required String email}) =>
      DeligateClientCreated.fromState(this, password: password, email: email);

  @override
  List<Object?> get props => [
        address,
        email,
        name,
        phone,
        townId,
      ];
}

final class DeligateClientsInitial extends DelegateCreateClientState {
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

final class DeligateClientCreated extends DelegateCreateClientState {
  final String password;

  const DeligateClientCreated({
    super.address = '',
    super.email = '',
    super.name = '',
    super.phone = '',
    super.fullName = '',
    super.townId = 20,
    required this.password,
    super.companyType = CompanyType.Pharmacy,
  });

  DeligateClientCreated.fromState(
    DelegateCreateClientState state, {
    required this.password,
    required super.email,
  }) : super(
            address: state.address,
            name: state.name,
            phone: state.phone,
            townId: state.townId,
            fullName: state.fullName,
            companyType: state.companyType);
}

final class DelegateClientCreationLoading extends DelegateCreateClientState {
  const DelegateClientCreationLoading({
    super.address = '',
    super.email = '',
    super.name = '',
    super.phone = '',
    super.fullName = '',
    super.townId = 20,
    super.companyType = CompanyType.Pharmacy,
  });

  DelegateClientCreationLoading.fromState(
    DelegateCreateClientState state,
  ) : super(
            address: state.address,
            email: state.email,
            name: state.name,
            phone: state.phone,
            townId: state.townId,
            fullName: state.fullName,
            companyType: state.companyType);
}

final class DeligateCreateClientLoading extends DelegateCreateClientState {
  DeligateCreateClientLoading.fromState(DelegateCreateClientState state)
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
    DelegateCreateClientState state, {
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
