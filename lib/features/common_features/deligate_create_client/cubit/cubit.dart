import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_create_client.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'state.dart';

class DeligateCreateClientCubit extends Cubit<DeligateCreateClientState> {
  final IClientsRepository clientsRepo;
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  DeligateCreateClientCubit({
    required this.clientsRepo,
  }) : super(const DeligateClientsInitial());

  void updateState({
    String? email,
    String? name,
    String? address,
    String? phone,
    String? fullName,
    int? townId,
    CompanyType? companyType,
  }) {
    emit(state.copyWith(
        email: email,
        name: name,
        address: address,
        phone: phone,
        fullName: fullName,
        townId: townId,
        companyType: companyType));
  }

  void submit(AppLocalizations translation) async {
    try {
      if (formKeys.currentState!.validate()) {
        emit(state.loading());
        final res = await clientsRepo.createClient(
          ParamsCreateClient(
              email: emailController.text,
              name: nameController.text,
              address: addressController.text,
              phone: phoneController.text,
              fullName: fullNameController.text,
              companyType: state.companyType,
              townId: state.townId),
        );

        RoutingManager.router.pop();
        getItInstance.get<ToastManager>().showToast(
            type: ToastType.success, message: translation.client_add_success);

        emit(state.created(password: res.password, email: res.email));
      }
    } catch (e) {
      getItInstance.get<ToastManager>().showToast(
          type: ToastType.error, message: translation.client_add_fail);
      emit(state.failed(e.toString()));
    }
  }
}
