

import 'dart:convert';

import '../auth/login_response_model.dart';

AirtimeCountryModel airtimeCountryModelFromJson(String str) => AirtimeCountryModel.fromJson(json.decode(str));

class AirtimeCountryModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  AirtimeCountryModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AirtimeCountryModel.fromJson(Map<String, dynamic> json) => AirtimeCountryModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Country>? countries;

  Data({
    this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
  );
}

class Country {
  int? id;
  String? name;
  String? isoName;
  String? continent;
  String? currencyCode;
  String? currencyName;
  String? currencySymbol;
  String? flagUrl;
  List<String>? callingCodes;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;

  Country({
    this.id,
    this.name,
    this.isoName,
    this.continent,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.flagUrl,
    this.callingCodes,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"] != null ? json["name"].toString() : "",
    isoName: json["iso_name"] != null ? json["iso_name"].toString() : "",
    continent: json["continent"] != null ? json["continent"].toString() : "",
    currencyCode: json["currency_code"] != null ? json["currency_code"].toString() : "",
    currencyName: json["currency_name"] != null ? json["currency_name"].toString() : "",
    currencySymbol: json["currency_symbol"] != null ? json["currency_symbol"].toString() : "",
    flagUrl: json["flag_url"] != null ? json["flag_url"].toString() : "",
    callingCodes: json["calling_codes"] == null ? [] : List<String>.from(json["calling_codes"]!.map((x) => x)),
    status: json["status"] != null ? json["status"].toString() : "",
    createdAt: json["created_at"] != null ? json["created_at"].toString() : "",
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : "",
  );
}

/*class Operator {
  int? id;
  String? countryId;
  String? uniqueId;
  String? name;
  String? bundle;
  String? data;
  String? pin;
  String? supportsLocalAmount;
  String? supportsGeographicalRechargePlans;
  String? denominationType;
  String? senderCurrencyCode;
  String? senderCurrencySymbol;
  String? destinationCurrencyCode;
  String? destinationCurrencySymbol;
  String? commission;
  String? internationalDiscount;
  String? localDiscount;
  String? mostPopularAmount;
  String? mostPopularLocalAmount;
  String? minAmount;
  String? maxAmount;
  String? localMinAmount;
  String? localMaxAmount;
  Fx? fx;
  List<String>? logoUrls;
  List<dynamic>? fixedAmounts;
  // Map<String, String>? fixedAmountsDescriptions;
  List<Description>? fixedAmountsDescriptions;
  List<dynamic>? localFixedAmounts;
  LocalFixedAmountsDescriptions? localFixedAmountsDescriptions;
  List<dynamic>? suggestedAmounts;
  SuggestedAmountsMap? suggestedAmountsMap;
  Fees? fees;
  List<dynamic>? geographicalRechargePlans;
  String? reloadlyStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  Operator({
    this.id,
    this.countryId,
    this.uniqueId,
    this.name,
    this.bundle,
    this.data,
    this.pin,
    this.supportsLocalAmount,
    this.supportsGeographicalRechargePlans,
    this.denominationType,
    this.senderCurrencyCode,
    this.senderCurrencySymbol,
    this.destinationCurrencyCode,
    this.destinationCurrencySymbol,
    this.commission,
    this.internationalDiscount,
    this.localDiscount,
    this.mostPopularAmount,
    this.mostPopularLocalAmount,
    this.minAmount,
    this.maxAmount,
    this.localMinAmount,
    this.localMaxAmount,
    this.fx,
    this.logoUrls,
    this.fixedAmounts,
    this.fixedAmountsDescriptions,
    this.localFixedAmounts,
    this.localFixedAmountsDescriptions,
    this.suggestedAmounts,
    this.suggestedAmountsMap,
    this.fees,
    this.geographicalRechargePlans,
    this.reloadlyStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
    id: json["id"],
    countryId: json["country_id"] != null ? json["country_id"].toString() : "",
    uniqueId: json["unique_id"] != null ? json["unique_id"].toString() : "",
    name: json["name"] != null ? json["name"].toString() : "",
    bundle: json["bundle"] != null ? json["bundle"].toString() : "",
    data: json["data"] != null ? json["data"].toString() : "",
    pin: json["pin"] != null ? json["pin"].toString() : "",
    supportsLocalAmount: json["supports_local_amount"] != null ? json["supports_local_amount"].toString() : "",
    supportsGeographicalRechargePlans: json["supports_geographical_recharge_plans"] != null ? json["supports_geographical_recharge_plans"].toString() : "",
    denominationType: json["denomination_type"] != null ? json["denomination_type"].toString() : "",
    senderCurrencyCode: json["sender_currency_code"] != null ? json["sender_currency_code"].toString() : "",
    senderCurrencySymbol: json["sender_currency_symbol"] != null ? json["sender_currency_symbol"].toString() : "",
    destinationCurrencyCode: json["destination_currency_code"] != null ? json["destination_currency_code"].toString() : "",
    destinationCurrencySymbol: json["destination_currency_symbol"] != null ? json["destination_currency_symbol"].toString() : "",
    commission: json["commission"] != null ? json["commission"].toString() : "",
    internationalDiscount: json["international_discount"] != null ? json["international_discount"].toString() : "",
    localDiscount: json["local_discount"] != null ? json["local_discount"].toString() : "",
    mostPopularAmount: json["most_popular_amount"] != null ? json["most_popular_amount"].toString() : "",
    mostPopularLocalAmount: json["most_popular_local_amount"] != null ? json["most_popular_local_amount"].toString() : "",
    minAmount: json["min_amount"] != null ? json["min_amount"].toString() : "",
    maxAmount: json["max_amount"] != null ? json["max_amount"].toString() : "",
    localMinAmount: json["local_min_amount"] != null ? json["local_min_amount"].toString() : "",
    localMaxAmount: json["local_max_amount"] != null ? json["local_max_amount"].toString() : "",
    fx: json["fx"] == null ? null : Fx.fromJson(json["fx"]),
    logoUrls: json["logo_urls"] == null ? [] : List<String>.from(json["logo_urls"]!.map((x) => x)),
    fixedAmounts: json["fixed_amounts"] == null ? [] : List<dynamic>.from(json["fixed_amounts"]!.map((x) => x)),

    // fixedAmountsDescriptions: Map.from(json["fixed_amounts_descriptions"] ?? []).map((k, v) => MapEntry<String, String>(k, v)),
    fixedAmountsDescriptions: json["fixed_amounts_descriptions"] == null || Map.from(json["fixed_amounts_descriptions"]).isEmpty ? [] :
    Map.from(json["fixed_amounts_descriptions"]).map((key, value) => MapEntry(key, value)).entries.map((e) => Description(
        amount: e.key ?? "",
        description: e.value ?? ""
    )).toList(),
    // Map.from(json["fixed_amounts_descriptions"]).entries.map((e){
    //   return {
    //     "amount" : e.key,
    //     "description" : e.value
    //   }
    // }).toList(),

    localFixedAmounts: json["local_fixed_amounts"] == null ? [] : List<dynamic>.from(json["local_fixed_amounts"]!.map((x) => x)),
    localFixedAmountsDescriptions: json["local_fixed_amounts_descriptions"] == null ? null : LocalFixedAmountsDescriptions.fromJson(json["local_fixed_amounts_descriptions"]),
    suggestedAmounts: json["suggested_amounts"] == null ? [] : List<dynamic>.from(json["suggested_amounts"]!.map((x) => x)),
    suggestedAmountsMap: json["suggested_amounts_map"] == null ? null : SuggestedAmountsMap.fromJson(json["suggested_amounts_map"]),
    fees: json["fees"] == null ? null : Fees.fromJson(json["fees"]),
    geographicalRechargePlans: json["geographical_recharge_plans"] == null ? [] : List<dynamic>.from(json["geographical_recharge_plans"]!.map((x) => x)),
    reloadlyStatus: json["reloadly_status"] != null ? json["reloadly_status"].toString() : "",
    status: json["status"] != null ? json["status"].toString() : "",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}*/

// class Description{
//
//   String? amount;
//   String? description;
//
//   Description({this.amount, this.description});
//
// }




