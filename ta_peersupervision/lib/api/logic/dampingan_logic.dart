class Dampingan {
  int? reqid;
  String initial;
  String? fakultas;
  int? angkatan;
  String? gender;
  String? kampus;
  String mediakontak;
  String kontak;
  String katakunci;
  String sesi;
  int? psnim;
  String? psname;

  Dampingan({
    this.reqid,
    required this.initial,
    this.fakultas,
    this.angkatan,
    this.gender,
    this.kampus,
    required this.mediakontak,
    required this.kontak,
    required this.katakunci,
    required this.sesi,
    this.psnim,
    this.psname,
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
      sesi: json['sesi'],
      psnim: json['psnim'],
      psname: json['psname'],
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
    data['sesi'] = sesi;
    data['psnim'] = psnim;
    data['psname'] = psname;

    return data;
  }
}