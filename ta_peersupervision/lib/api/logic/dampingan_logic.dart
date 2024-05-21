class Dampingan {
  final int reqid;
  final String initial;
  final String? fakultas;
  final int? angkatan;
  final String? gender;
  final String? kampus;
  final String mediakontak;
  final String kontak;
  final String katakunci;
  final String sesi;
  final int? psnim;
  late final DateTime? tanggal;
  final String? psname;

  Dampingan({
    required this.reqid,
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
    this.tanggal,
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
      tanggal: json['tanggal'] != null ? DateTime.parse(json['tanggal']) : null, // Nullable value,
      psname: json['psname'],
    );
  }
}



class JadwalPendampingan {
  int? reqid;
  String? tanggal;

  JadwalPendampingan({
    this.reqid,
    this.tanggal,
  });

  JadwalPendampingan.fromJson(Map<String, dynamic> json) {
    reqid = json['reqid'];
    tanggal = json['tanggal'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqid'] = reqid;
    data['tanggal'] = DateTime.parse(tanggal!);

    return data;
  }
  
}
