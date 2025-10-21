class Medicine {
  final dynamic image;
  final String registrationNumber;
  final String code;
  final String dci;
  final String brandName;
  final String form;
  final String dosage;
  final String packaging;
  final String list;
  final String p1;
  final String p2;
  final String? obs;
  final String laboratoryHolder;
  final String laboratoryCountry;
  final DateTime? initialRegistrationDate;
  final DateTime? finalRegistrationDate;
  final String type;
  final String status;
  final String lifeTime;
  final bool isActive;

  Medicine({
    required this.image,
    required this.registrationNumber,
    required this.code,
    required this.dci,
    required this.brandName,
    required this.form,
    required this.dosage,
    required this.packaging,
    required this.list,
    required this.p1,
    required this.p2,
    required this.obs,
    required this.laboratoryHolder,
    required this.laboratoryCountry,
    required this.initialRegistrationDate,
    required this.finalRegistrationDate,
    required this.type,
    required this.status,
    required this.lifeTime,
    required this.isActive,
  });

  factory Medicine.empty() {
    return Medicine(
      image: '',
      registrationNumber: '',
      code: '',
      dci: '',
      brandName: '',
      form: '',
      dosage: '',
      packaging: '',
      list: '',
      p1: '',
      p2: '',
      obs: '',
      laboratoryHolder: '',
      laboratoryCountry: '',
      initialRegistrationDate: DateTime.now(),
      finalRegistrationDate: DateTime.now(),
      type: '',
      status: '',
      lifeTime: '',
      isActive: false,
    );
  }
}
