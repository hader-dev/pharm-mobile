import 'package:equatable/equatable.dart';

enum ParaMedicalFiltersKeys {
  sku,
  name,
  description,
  dosage,
  status,
  country,
  patent,
  vendors,
  brand,
  condition,
  type,
  stabilityDuration,
  code,
  reimbursement,
  unitPriceHt;
}

class ParaMedicalFilters extends Equatable {
  final List<String> dosage;
  final List<String> name;
  final List<String> description;
  final List<String> sku;
  final List<String> vendors;

  final List<String> status;
  final List<String> registrationDate;
  final List<String> country;
  final List<String> patent;

  final List<String> brand;
  final List<String> condition;
  final List<String> type;

  final List<String> stabilityDuration;

  final List<String> code;
  final List<String> reimbursement;

  final String? gteUnitPriceHt;
  final String? lteUnitPriceHt;
  final String? sourceCompanyId;

  const ParaMedicalFilters({
    this.sourceCompanyId,
    this.name = const [],
    this.vendors = const [],
    this.description = const [],
    this.sku = const [],
    this.dosage = const [],
    this.status = const [],
    this.registrationDate = const [],
    this.country = const [],
    this.patent = const [],
    this.brand = const [],
    this.condition = const [],
    this.type = const [],
    this.stabilityDuration = const [],
    this.code = const [],
    this.reimbursement = const [],
    this.gteUnitPriceHt,
    this.lteUnitPriceHt,
  });

  ParaMedicalFilters copyWith({
    List<String>? name,
    List<String>? description,
    List<String>? sku,
    List<String>? dosage,
    List<String>? status,
    List<String>? country,
    List<String>? patent,
    List<String>? brand,
    List<String>? vendors,
    List<String>? condition,
    List<String>? type,
    List<String>? stabilityDuration,
    List<String>? code,
    List<String>? reimbursement,
    String? gteUnitPriceHt,
    String? lteUnitPriceHt,
    bool resetGteUnitPriceHt = false,
    bool resetLteUnitPriceHt = false,
  }) {
    return ParaMedicalFilters(
      name: name ?? this.name,
      description: description ?? this.description,
      sku: sku ?? this.sku,
      dosage: dosage ?? this.dosage,
      status: status ?? this.status,
      country: country ?? this.country,
      patent: patent ?? this.patent,
      brand: brand ?? this.brand,
      vendors: vendors ?? this.vendors,
      condition: condition ?? this.condition,
      type: type ?? this.type,
      stabilityDuration: stabilityDuration ?? this.stabilityDuration,
      code: code ?? this.code,
      reimbursement: reimbursement ?? this.reimbursement,
      gteUnitPriceHt:
          resetGteUnitPriceHt ? null : (gteUnitPriceHt ?? this.gteUnitPriceHt),
      lteUnitPriceHt:
          resetLteUnitPriceHt ? null : (lteUnitPriceHt ?? this.lteUnitPriceHt),
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        sku,
        dosage,
        status,
        country,
        patent,
        brand,
        condition,
        type,
        stabilityDuration,
        sku,
        code,
        reimbursement,
        gteUnitPriceHt,
        lteUnitPriceHt,
        vendors
      ];

  bool get isNotEmpty =>
      name.isNotEmpty ||
      description.isNotEmpty ||
      sku.isNotEmpty ||
      dosage.isNotEmpty ||
      status.isNotEmpty ||
      country.isNotEmpty ||
      patent.isNotEmpty ||
      brand.isNotEmpty ||
      condition.isNotEmpty ||
      type.isNotEmpty ||
      stabilityDuration.isNotEmpty ||
      code.isNotEmpty ||
      reimbursement.isNotEmpty;

  ParaMedicalFilters updateSearchFilter(
      ParaMedicalFiltersKeys key, String text) {
    matchList(List<String> list) => list
        .where((el) => el.toLowerCase().contains(text.toLowerCase()))
        .toList();

    switch (key) {
      case ParaMedicalFiltersKeys.vendors:
        return copyWith(vendors: matchList(vendors));
      case ParaMedicalFiltersKeys.name:
        return copyWith(name: matchList(name));

      case ParaMedicalFiltersKeys.description:
        return copyWith(description: matchList(description));

      case ParaMedicalFiltersKeys.sku:
        return copyWith(sku: matchList(sku));

      case ParaMedicalFiltersKeys.dosage:
        return copyWith(dosage: matchList(dosage));
      case ParaMedicalFiltersKeys.status:
        return copyWith(status: matchList(status));
      case ParaMedicalFiltersKeys.country:
        return copyWith(country: matchList(country));
      case ParaMedicalFiltersKeys.patent:
        return copyWith(patent: matchList(patent));
      case ParaMedicalFiltersKeys.brand:
        return copyWith(brand: matchList(brand));
      case ParaMedicalFiltersKeys.condition:
        return copyWith(condition: matchList(condition));
      case ParaMedicalFiltersKeys.type:
        return copyWith(type: matchList(type));
      case ParaMedicalFiltersKeys.stabilityDuration:
        return copyWith(stabilityDuration: matchList(stabilityDuration));
      case ParaMedicalFiltersKeys.code:
        return copyWith(code: matchList(code));
      case ParaMedicalFiltersKeys.reimbursement:
        return copyWith(reimbursement: matchList(reimbursement));
      case ParaMedicalFiltersKeys.unitPriceHt:
        return this;
    }
  }

  List<String> getFilterBykey(ParaMedicalFiltersKeys currentkey) {
    switch (currentkey) {
      case ParaMedicalFiltersKeys.vendors:
        return vendors;
      case ParaMedicalFiltersKeys.name:
        return name;
      case ParaMedicalFiltersKeys.description:
        return description;
      case ParaMedicalFiltersKeys.sku:
        return sku;

      case ParaMedicalFiltersKeys.dosage:
        return dosage;
      case ParaMedicalFiltersKeys.status:
        return status;
      case ParaMedicalFiltersKeys.country:
        return country;
      case ParaMedicalFiltersKeys.patent:
        return patent;
      case ParaMedicalFiltersKeys.brand:
        return brand;
      case ParaMedicalFiltersKeys.condition:
        return condition;
      case ParaMedicalFiltersKeys.type:
        return type;
      case ParaMedicalFiltersKeys.stabilityDuration:
        return stabilityDuration;
      case ParaMedicalFiltersKeys.code:
        return code;
      case ParaMedicalFiltersKeys.reimbursement:
        return reimbursement;
      case ParaMedicalFiltersKeys.unitPriceHt:
        return [];
    }
  }

  ParaMedicalFilters updateFilterList(
      ParaMedicalFiltersKeys key, List<String> updatedFilters) {
    switch (key) {
      case ParaMedicalFiltersKeys.vendors:
        return copyWith(vendors: updatedFilters);
      case ParaMedicalFiltersKeys.name:
        return copyWith(name: updatedFilters);
      case ParaMedicalFiltersKeys.description:
        return copyWith(description: updatedFilters);
      case ParaMedicalFiltersKeys.sku:
        return copyWith(sku: updatedFilters);

      case ParaMedicalFiltersKeys.dosage:
        return copyWith(dosage: updatedFilters);
      case ParaMedicalFiltersKeys.status:
        return copyWith(status: updatedFilters);
      case ParaMedicalFiltersKeys.country:
        return copyWith(country: updatedFilters);
      case ParaMedicalFiltersKeys.patent:
        return copyWith(patent: updatedFilters);
      case ParaMedicalFiltersKeys.brand:
        return copyWith(brand: updatedFilters);
      case ParaMedicalFiltersKeys.condition:
        return copyWith(condition: updatedFilters);
      case ParaMedicalFiltersKeys.type:
        return copyWith(type: updatedFilters);
      case ParaMedicalFiltersKeys.stabilityDuration:
        return copyWith(stabilityDuration: updatedFilters);
      case ParaMedicalFiltersKeys.code:
        return copyWith(code: updatedFilters);
      case ParaMedicalFiltersKeys.reimbursement:
        return copyWith(reimbursement: updatedFilters);
      case ParaMedicalFiltersKeys.unitPriceHt:
        return this;
    }
  }
}
