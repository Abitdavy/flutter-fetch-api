class KaryawanModel {
  int? id;
  String nik;
  String nama;
  int umur;
  String kota;

  KaryawanModel({
    this.id,
    required this.nik,
    required this.nama,
    required this.umur,
    required this.kota,
  });

  factory KaryawanModel.fromJson(Map<String, dynamic> json) => KaryawanModel(
        id: json['id'],
        nik: json['nik'],
        nama: json['nama'],
        umur: json['umur'],
        kota: json['kota'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'nama': nama,
        'umur': umur,
        'kota': kota,
      };
}
