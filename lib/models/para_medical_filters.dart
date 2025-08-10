import 'package:equatable/equatable.dart';

enum ParaMedicalFiltersKeys {
  sku,
  name,
  description,
  dosage,
  status,
  country,
  patent,
  brand,
  condition,
  type,
  stabilityDuration,
  code,
  reimbursement,
  distributorSku,
  unitPriceHt;
}

class ParaMedicalFilters extends Equatable {
  final List<String> dosage;
  final List<String> name;
  final List<String> description;
  final List<String> sku;

  final List<String> status;
  final List<String> registrationDate;
  final List<String> country;
  final List<String> patent;
  final List<String> distributorSku;

  final List<String> brand;
  final List<String> condition;
  final List<String> type;

  final List<String> stabilityDuration;

  final List<String> code;
  final List<String> reimbursement;

  final String? gteUnitPriceHt;
  final String? lteUnitPriceHt;



  const ParaMedicalFilters({
    this.name = const [],
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
    this.distributorSku = const [],
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
    List<String>? condition,
    List<String>? type,
    List<String>? stabilityDuration,
    List<String>? distributorSku,
    List<String>? code,
    List<String>? reimbursement,
    String? gteUnitPriceHt,
    String? lteUnitPriceHt,

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
      condition: condition ?? this.condition,
      type: type ?? this.type,
      stabilityDuration: stabilityDuration ?? this.stabilityDuration,
      distributorSku: distributorSku ?? this.distributorSku,
      code: code ?? this.code,
      reimbursement: reimbursement ?? this.reimbursement,
      gteUnitPriceHt: gteUnitPriceHt ?? this.gteUnitPriceHt,
      lteUnitPriceHt: lteUnitPriceHt ?? this.lteUnitPriceHt,

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
        distributorSku,
        code,
        reimbursement,
        gteUnitPriceHt,
        lteUnitPriceHt,
      ];

  ParaMedicalFilters updateSearchFilter(ParaMedicalFiltersKeys key, String text) {
    matchList(List<String> list) =>
        list.where((el) => el.toLowerCase().contains(text.toLowerCase())).toList();

    switch (key) {

      case ParaMedicalFiltersKeys.name:
        return copyWith(name: matchList(name));

      case ParaMedicalFiltersKeys.description:
        return copyWith(description: matchList(description));

      case ParaMedicalFiltersKeys.sku:
        return copyWith(sku: matchList(sku));

      case ParaMedicalFiltersKeys.distributorSku:
        return copyWith(distributorSku: matchList(distributorSku));
      
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

      case ParaMedicalFiltersKeys.name:
        return name;
        case ParaMedicalFiltersKeys.description:
        return description;
        case ParaMedicalFiltersKeys.sku:
        return  sku;

      case ParaMedicalFiltersKeys.distributorSku:
        return distributorSku;
      
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


      case ParaMedicalFiltersKeys.name:
        return copyWith(name: updatedFilters);
      case ParaMedicalFiltersKeys.description:
        return copyWith(description: updatedFilters);
      case ParaMedicalFiltersKeys.sku:
        return copyWith(sku: updatedFilters);

      case ParaMedicalFiltersKeys.distributorSku:
        return copyWith(distributorSku: updatedFilters);
     
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
