class MyJadwal {
  int jadwalid;
  int reqid;
  DateTime tanggal;
  String initial;
  int psnim;
  String psname;
  String mediapendampingan;
  String katakunci;

  MyJadwal({
    required this.jadwalid,
    required this.reqid,
    required this.tanggal,
    required this.initial,
    required this.psnim,
    required this.psname,
    required this.mediapendampingan,
    required this.katakunci,
  });

  factory MyJadwal.fromJson(Map<String, dynamic> json) {
    return MyJadwal(
      jadwalid: json['jadwalid'],
      reqid: json['reqid'],
      tanggal: DateTime.parse(json['tanggalKonversi']),
      initial: json['initial'],
      psnim: json['psnim'],
      psname: json['psname'],
      mediapendampingan: json['mediapendampingan'],
      katakunci: json['katakunci'],
    );
  }
}
