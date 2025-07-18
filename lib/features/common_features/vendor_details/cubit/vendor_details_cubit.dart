import 'package:bloc/bloc.dart';

import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  late final Company vendorData;
  final CompanyRepository companyRepo;
  VendorDetailsCubit({required this.companyRepo}) : super(VendorDetailsInitial());

  void getVendorDetails(String companyId) async {
    try {
      emit(VendorDetailsLoading());
      vendorData = await companyRepo.getCompanyById(companyId: companyId);
      emit(VendorDetailsLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorDetailsLoadingError());
    }
  }

  Future<void> requestJoinVendorAsClient(String vendorId) async {
    try {
      emit(SendingJoinRequest());
      await companyRepo.joinCompanyAsCLient(companyId: vendorId);
      emit(JoinRequestSent());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorDetailsLoadingError());
    }
  }

  Future<void> likeVendor(String vendorId) async {
    try {
      await companyRepo.addCompanyToFavorites(companyId: vendorId);
      emit(VendorLiked());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorLikeFailed());
    }
  }
}
