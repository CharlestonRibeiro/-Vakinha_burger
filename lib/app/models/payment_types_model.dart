import 'dart:convert';

class PaymentTypesModel {

  final int id;
  final String name;
  final String acronym;
  final bool enabled;

  PaymentTypesModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentTypesModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enabled: map['enabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypesModel.fromJson(String source) => PaymentTypesModel.fromMap(json.decode(source));
}