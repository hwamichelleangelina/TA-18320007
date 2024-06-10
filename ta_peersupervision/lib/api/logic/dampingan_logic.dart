class Dampingan {
  int? reqid;
  String initial;
  String? fakultas;
  int? angkatan;
  String? gender;
  String? kampus;
  String mediakontak;
  String kontak;
  String? katakunci;
  String? katakunci2;
  String sesi;
  int? psnim;
  String? psname;
  String? tingkat;

  Dampingan({
    this.reqid,
    required this.initial,
    this.fakultas,
    this.angkatan,
    this.gender,
    this.kampus,
    required this.mediakontak,
    required this.kontak,
    this.katakunci,
    this.katakunci2,
    required this.sesi,
    this.psnim,
    this.psname,
    this.tingkat,
  });

  factory Dampingan.fromJson(Map<String, dynamic> json) {

    return Dampingan(
      reqid: json['reqid'],
      initial: json['initial'],
      fakultas: json['fakultas'],
      angkatan: json['angkatan'],
      gender: json['gender'],
      kampus: json['kampus'],
      mediakontak: json['mediakontak'],
      kontak: json['kontak'],
      katakunci: json['katakunci'],
      katakunci2: json['katakunci2'],
      sesi: json['sesi'],
      psnim: json['psnim'],
      psname: json['psname'],
      tingkat: json['tingkat']
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqid'] = reqid;
    data['initial'] = initial;
    data['fakultas'] = fakultas;
    data['angkatan'] = angkatan;
    data['gender'] = gender;
    data['kampus'] = kampus;
    data['mediakontak'] = mediakontak;
    data['kontak'] = kontak;
    data['katakunci'] = katakunci;
    data['katakunci2'] = katakunci2;
    data['sesi'] = sesi;
    data['psnim'] = psnim;
    data['psname'] = psname;
    data['tingkat'] = tingkat;

    return data;
  }
}