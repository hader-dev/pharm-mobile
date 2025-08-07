import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class ResponseLoadAnnouncementDetails {
  final Company? company;
  final List<MedicineCatalogModel> medicines;
  final List<ParaPharmaCatalogModel> parapharmas;
  final AnnouncementModel? announcement;

  ResponseLoadAnnouncementDetails({
    this.announcement,
    this.company,
    this.medicines = const [],
    this.parapharmas = const [],
  });
}
