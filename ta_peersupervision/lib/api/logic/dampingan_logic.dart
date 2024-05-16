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
  final DateTime? tanggal;
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
    if (json['tanggal'] == null) {
      json['tanggal'] = '';
    }

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
      tanggal: DateTime.parse(json['tanggal']!),
      psname: json['psname'],
    );
  }
}



class JadwalPendampingan {
  final int reqid;
  final DateTime tanggal;

  JadwalPendampingan({
    required this.reqid,
    required this.tanggal,
  });

  factory JadwalPendampingan.fromJson(Map<String, dynamic> json) {
    return JadwalPendampingan(
      reqid: json['reqid'],
      tanggal: json['tanggal'],
    );
  }
}
