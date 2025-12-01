import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  final ICompanyRepository companyRepo;
  VendorDetailsCubit({required this.companyRepo}) : super(VendorDetailsInitial());

  void getVendorDetails(String companyId) async {
    try {
      emit(state.toLoading());
      final vendorData = await companyRepo.getCompanyById(companyId: companyId);
      emit(state.toLoaded(vendor: vendorData));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  Future<void> requestJoinVendorAsClient(String vendorId) async {
    try {
      emit(state.toSendingJoinRequest());
      await companyRepo.joinCompanyAsCLient(companyId: vendorId);
      emit(state.toJoinRequestSent());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  Future<void> likeVendor(String vendorId) async {
    try {
      await companyRepo.likeVendor(companyId: vendorId);
      emit(state.toVendorLiked());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toVendorLikeFailed());
    }
  }

  void unlikeVendor(String id) {
    try {
      companyRepo.unlikeVendor(companyId: id);
      emit(state.toVendorLiked());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toVendorLikeFailed());
    }
  }

  void unfollowVendor(String id) async {
    try {
      emit(state.toSendingJoinRequest());
      await companyRepo.unJoinCompanyAsCLient(companyId: id);
      emit(state.toJoinRequestSent());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }
}
