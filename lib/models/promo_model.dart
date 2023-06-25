// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  String? id;
  String? kode;
  String? nama;
  String? image;
  double? value;
  double? maksimalPromo;
  String? expired;
  int? quota;
  String? jenis;
  String? jenisPengguna;
  String? desc;
  String? status;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? isDeleted;
  String? jenisPenggunaTxt;

  PromoModel({
    this.id,
    this.kode,
    this.nama,
    this.image,
    this.value,
    this.maksimalPromo,
    this.expired,
    this.quota,
    this.jenis,
    this.jenisPengguna,
    this.desc,
    this.status,
    this.createdAt,
    this.createdBy,
    this.modifiedAt,
    this.modifiedBy,
    this.isDeleted,
    this.jenisPenggunaTxt,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        image: json["image"],
        value: double.parse(json["value"].toString()),
        maksimalPromo: double.parse(json["maksimal_promo"].toString()),
        expired: json["expired"],
        quota: int.parse(json["quota"]),
        jenis: json["jenis"],
        jenisPengguna: json["jenis_pengguna"],
        desc: json["desc"],
        status: json["status"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        modifiedAt: json["modified_at"],
        modifiedBy: json["modified_by"],
        isDeleted: json["is_deleted"],
        jenisPenggunaTxt: json["jenis_pengguna_txt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "image": image,
        "value": value,
        "maksimal_promo": maksimalPromo,
        "expired": expired,
        "quota": quota,
        "jenis": jenis,
        "jenis_pengguna": jenisPengguna,
        "desc": desc,
        "status": status,
        "created_at": createdAt,
        "created_by": createdBy,
        "modified_at": modifiedAt,
        "modified_by": modifiedBy,
        "is_deleted": isDeleted,
        "jenis_pengguna_txt": jenisPenggunaTxt,
      };
}