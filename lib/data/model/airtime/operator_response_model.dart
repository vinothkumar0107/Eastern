

import 'dart:convert';

import '../auth/login_response_model.dart';

OperatorResponseModel operatorResponseModelFromJson(String str) => OperatorResponseModel.fromJson(json.decode(str));


class OperatorResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  OperatorResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory OperatorResponseModel.fromJson(Map<String, dynamic> json) => OperatorResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<TabsModel>? tabs;

  Data({
    this.tabs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    // tabs: json["tabs"] == null ? null : Tabs.fromJson(json["tabs"]),
    tabs: json["tabs"] == null ? null : (json['tabs'] as Map<String, dynamic>?)?.entries.map((e){
      print('value: ${e.key}');
      print('value: ${e.value}');
      return TabsModel(
        title: e.key,
        // operator: e.value
        operator:e.value != null ? List<Operator>.from(e.value.map((x) => Operator.fromJson(x))) : []
      );
    }).toList(),
  );
}

// class Tabs {
//   List<Operator>? all;
//
//   Tabs({
//     this.all,
//   });
//
//   factory Tabs.fromJson(Map<String, dynamic> json) => Tabs(
//     all: json["all"] == null ? [] : List<Operator>.from(json["all"]!.map((x) => Operator.fromJson(x))),
//   );
// }


class TabsModel {
  String? title;
  List<Operator>? operator;

  TabsModel({
    this.title,
    this.operator,
  });
}

class Operator {
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
  dynamic mostPopularLocalAmount;
  String? minAmount;
  String? maxAmount;
  dynamic localMinAmount;
  dynamic localMaxAmount;
  Fx? fx;
  List<String>? logoUrls;
  List<String>? fixedAmounts;
  // Map<String, String>? fixedAmountsDescriptions;
  List<Description>? fixedAmountsDescriptions;
  List<dynamic>? localFixedAmounts;
  LocalFixedAmountsDescriptions? localFixedAmountsDescriptions;
  List<String>? suggestedAmounts;
  LocalFixedAmountsDescriptions? suggestedAmountsMap;
  Fees? fees;
  List<dynamic>? geographicalRechargePlans;
  String? status;
  String? reloadlyStatus;
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
    this.status,
    this.reloadlyStatus,
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
    fixedAmounts: json["fixed_amounts"] == null ? [] : List<String>.from(json["fixed_amounts"]!.map((x) => x?.toString())),
    // fixedAmountsDescriptions: Map.from(json["fixed_amounts_descriptions"]!).map((k, v) => MapEntry<String, String>(k, v)),
      fixedAmountsDescriptions: json["fixed_amounts_descriptions"] == null || Map.from(json["fixed_amounts_descriptions"]).isEmpty ? [] :
    Map.from(json["fixed_amounts_descriptions"]).map((key, value) => MapEntry(key, value)).entries.map((e) => Description(
        amount: e.key ?? "",
        description: e.value ?? ""
    )).toList(),
    localFixedAmounts: json["local_fixed_amounts"] == null ? [] : List<dynamic>.from(json["local_fixed_amounts"]!.map((x) => x)),
    localFixedAmountsDescriptions: json["local_fixed_amounts_descriptions"] == null ? null : LocalFixedAmountsDescriptions.fromJson(json["local_fixed_amounts_descriptions"]),
    suggestedAmounts: json["suggested_amounts"] == null ? [] : List<String>.from(json["suggested_amounts"]!.map((x) => x?.toString())),
    suggestedAmountsMap: json["suggested_amounts_map"] == null ? null : LocalFixedAmountsDescriptions.fromJson(json["suggested_amounts_map"]),
    fees: json["fees"] == null ? null : Fees.fromJson(json["fees"]),
    geographicalRechargePlans: json["geographical_recharge_plans"] == null ? [] : List<dynamic>.from(json["geographical_recharge_plans"]!.map((x) => x)),
    status: json["status"] != null ? json["status"].toString() : "",
    reloadlyStatus: json["reloadly_status"] != null ? json["reloadly_status"].toString() : "",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"]);
}

class Description{

  String? amount;
  String? description;

  Description({this.amount, this.description});

}

class Fees {
  String? international;
  String? local;
  String? localPercentage;
  String? internationalPercentage;

  Fees({
    this.international,
    this.local,
    this.localPercentage,
    this.internationalPercentage,
  });

  factory Fees.fromJson(Map<String, dynamic> json) => Fees(
    international: json["international"] != null ? json["international"].toString() : "",
    local: json["local"] != null ? json["local"].toString() : "",
    localPercentage: json["localPercentage"] != null ? json["localPercentage"].toString() : "",
    internationalPercentage: json["internationalPercentage"] != null ? json["internationalPercentage"].toString() : "",
  );
}

class Fx {
  String? rate;
  String? currencyCode;

  Fx({
    this.rate,
    this.currencyCode,
  });

  factory Fx.fromJson(Map<String, dynamic> json) => Fx(
    rate: json["rate"] != null ? json["rate"].toString() : "",
    currencyCode: json["currencyCode"] != null ? json["currencyCode"].toString() : "",
  );
}

class LocalFixedAmountsDescriptions {
  LocalFixedAmountsDescriptions();

  factory LocalFixedAmountsDescriptions.fromJson(Map<String, dynamic> json) => LocalFixedAmountsDescriptions(
  );
}
