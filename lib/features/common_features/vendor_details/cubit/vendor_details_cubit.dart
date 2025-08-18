import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  Company vendorData = Company.empty();
  final ICompanyRepository companyRepo;
  VendorDetailsCubit({required this.companyRepo})
      : super(VendorDetailsInitial());

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

  void unlikeVendor(String id) {
    try {
      companyRepo.removeCompanyFromFavorites(companyId: id);
      emit(VendorLiked());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorLikeFailed());
    }
  }

  void unfollowVendor(String id) async {
    try {
      emit(SendingJoinRequest());
      await companyRepo.unJoinCompanyAsCLient(companyId: id);
      emit(JoinRequestSent());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(VendorDetailsLoadingError());
    }
  }
}
