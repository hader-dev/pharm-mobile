import 'package:equatable/equatable.dart';

class MedicalFilters extends Equatable {
  final List<String> dci;
  final List<String> dosage;
  final List<String> form;

  final List<String> status;
  final List<String> registrationDate;
  final List<String> country;
  final List<String> patent;
  final List<String> sku;

  final List<String> brand;
  final List<String> condition;
  final List<String> type;

  final List<String> stabilityDuration;
  final List<String> packagingFormat;

  final List<String> code;
  final List<String> reimbursement;
  final String? gteUnitPriceHt;
  final String? lteUnitPriceHt;

  const MedicalFilters({
    this.gteUnitPriceHt,
    this.lteUnitPriceHt,
    this.dci = const [],
    this.dosage = const [],
    this.form = const [],
    this.status = const [],
    this.registrationDate = const [],
    this.country = const [],
    this.patent = const [],
    this.brand = const [],
    this.condition = const [],
    this.type = const [],
    this.stabilityDuration = const [],
    this.sku = const [],
    this.packagingFormat = const [],
    this.code = const [],
    this.reimbursement = const [],
  });

  MedicalFilters copyWith({
    List<String>? dci,
    List<String>? dosage,
    List<String>? form,
    List<String>? status,
    List<String>? registrationDate,
    List<String>? country,
    List<String>? patent,
    List<String>? brand,
    List<String>? condition,
    List<String>? type,
    List<String>? stabilityDuration,
    List<String>? sku,
    List<String>? packagingFormat,
    List<String>? code,
    List<String>? reimbursement,
    String? gteUnitPriceHt,
    String? lteUnitPriceHt,
  }) {
    return MedicalFilters(
      gteUnitPriceHt: gteUnitPriceHt ?? this.gteUnitPriceHt,
      lteUnitPriceHt: lteUnitPriceHt ?? this.lteUnitPriceHt,
      dci: dci ?? this.dci,
      dosage: dosage ?? this.dosage,
      form: form ?? this.form,
      status: status ?? this.status,
      registrationDate: registrationDate ?? this.registrationDate,
      country: country ?? this.country,
      patent: patent ?? this.patent,
      brand: brand ?? this.brand,
      condition: condition ?? this.condition,
      type: type ?? this.type,
      stabilityDuration: stabilityDuration ?? this.stabilityDuration,
      sku: sku ?? this.sku,
      packagingFormat: packagingFormat ?? this.packagingFormat,
      code: code ?? this.code,
      reimbursement: reimbursement ?? this.reimbursement,
    );
  }

  @override
  List<Object?> get props => [
        gteUnitPriceHt,
        lteUnitPriceHt,
        dci,
        dosage,
        form,
        status,
        registrationDate,
        country,
        patent,
        brand,
        condition,
        type,
        stabilityDuration,
        sku,
        packagingFormat,
        code,
        reimbursement,
      ];

  MedicalFilters updateSearchFilter(MedicalFiltersKeys key, String text) {
    matchList(List<String> list) =>
        list.where((el) => el.contains(text)).toList();

    switch (key) {
      case MedicalFiltersKeys.distributorSku:
        return copyWith(sku: matchList(sku));
      case MedicalFiltersKeys.dci:
        return copyWith(dci: matchList(dci));
      case MedicalFiltersKeys.dosage:
        return copyWith(dosage: matchList(dosage));
      case MedicalFiltersKeys.form:
        return copyWith(form: matchList(form));
      case MedicalFiltersKeys.status:
        return copyWith(status: matchList(status));
      case MedicalFiltersKeys.laboratoryCountry:
        return copyWith(country: matchList(country));
      case MedicalFiltersKeys.laboratoryHolder:
        return copyWith(patent: matchList(patent));
      case MedicalFiltersKeys.brandName:
        return copyWith(brand: matchList(brand));
      // case MedicalFiltersKeys.condition:
      //   return copyWith(condition: matchList(condition));
      case MedicalFiltersKeys.type:
        return copyWith(type: matchList(type));
      // case MedicalFiltersKeys.stabilityDuration:
      //   return copyWith(stabilityDuration: matchList(stabilityDuration));
      case MedicalFiltersKeys.code:
        return copyWith(code: matchList(code));
      case MedicalFiltersKeys.p1:
        return copyWith(reimbursement: matchList(reimbursement));
      case MedicalFiltersKeys.unitPriceHt:
        return this;
    }
  }

  List<String> getFilterBykey(MedicalFiltersKeys currentkey) {
    switch (currentkey) {
      case MedicalFiltersKeys.distributorSku:
        return sku;
      case MedicalFiltersKeys.dci:
        return dci;
      case MedicalFiltersKeys.dosage:
        return dosage;
      case MedicalFiltersKeys.form:
        return form;
      case MedicalFiltersKeys.status:
        return status;
      case MedicalFiltersKeys.laboratoryCountry:
        return country;
      case MedicalFiltersKeys.laboratoryHolder:
        return patent;
      case MedicalFiltersKeys.brandName:
        return brand;
      // case MedicalFiltersKeys.condition:
      //   return condition;
      case MedicalFiltersKeys.type:
        return type;
      // case MedicalFiltersKeys.stabilityDuration:
      //   return stabilityDuration;
      case MedicalFiltersKeys.code:
        return code;
      case MedicalFiltersKeys.p1:
        return reimbursement;
      case MedicalFiltersKeys.unitPriceHt:
        return [];
    }
  }

  MedicalFilters updateFilterList(
      MedicalFiltersKeys key, List<String> updatedFilters) {
    switch (key) {
      case MedicalFiltersKeys.distributorSku:
        return copyWith(sku: updatedFilters);
      case MedicalFiltersKeys.dci:
        return copyWith(dci: updatedFilters);
      case MedicalFiltersKeys.dosage:
        return copyWith(dosage: updatedFilters);
      case MedicalFiltersKeys.form:
        return copyWith(form: updatedFilters);
      case MedicalFiltersKeys.status:
        return copyWith(status: updatedFilters);
      case MedicalFiltersKeys.laboratoryCountry:
        return copyWith(country: updatedFilters);
      case MedicalFiltersKeys.laboratoryHolder:
        return copyWith(patent: updatedFilters);
      case MedicalFiltersKeys.brandName:
        return copyWith(brand: updatedFilters);
      // case MedicalFiltersKeys.condition:
      //   return copyWith(condition: updatedFilters);
      case MedicalFiltersKeys.type:
        return copyWith(type: updatedFilters);
      // case MedicalFiltersKeys.stabilityDuration:
      //   return copyWith(stabilityDuration: updatedFilters);
      case MedicalFiltersKeys.code:
        return copyWith(code: updatedFilters);

      case MedicalFiltersKeys.unitPriceHt:
        return this;
      case MedicalFiltersKeys.p1:
        return copyWith(reimbursement: updatedFilters);
    }
  }
}

enum MedicalFiltersKeys {
  dci,
  dosage,
  form,
  status,
  laboratoryCountry,
  laboratoryHolder,
  brandName,
  // condition, api not supported
  type,
  // stabilityDuration, api not supported
  code,
  p1,
  distributorSku,
  unitPriceHt,
}
