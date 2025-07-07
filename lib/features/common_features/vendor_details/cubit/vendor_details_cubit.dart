import 'package:bloc/bloc.dart';

import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  late final Company vendorData;
  final CompanyRepository companyRepo;
  VendorDetailsCubit({required this.companyRepo}) : super(VendorDetailsInitial());

  void intVendorDetails(Company companyData) {
    try {
      emit(VendorDetailsLoading());
      vendorData = companyData;
      emit(VendorDetailsLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorDetailsLoadingError());
    }
  }

  Future<void> requestJoinVendorAsClient() async {
    try {
      emit(sendingJoinRequest());
      await companyRepo.joinCompanyAsCLient(companyId: vendorData.id);
      emit(joinRequestSent());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorDetailsLoadingError());
    }
  }
}
