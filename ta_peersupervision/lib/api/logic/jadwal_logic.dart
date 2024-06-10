class Jadwal {
  int? jadwalid;
  int? reqid;
  String? initial;
  int? psnim;
  String? tanggal;
  String? psname;
  String? mediapendampingan;
  String? katakunci;
  String? katakunci2;
  String? tanggalKonversi;

  Jadwal({
    required this.reqid,
    this.initial,
    this.psnim,
    required this.tanggal,
    this.psname,
    this.mediapendampingan,
    this.katakunci,
    this.katakunci2,
    this.tanggalKonversi
  });

  Jadwal.fromJson(Map<String, dynamic> json) {
    reqid = json['reqid'];
    initial = json['initial'];
    tanggalKonversi = json['tanggalKonversi'];
    psnim = json['psnim'];
    psname = json['psname'];
    mediapendampingan = json['mediapendampingan'];
    katakunci = json['katakunci'];
    katakunci2 = json['katakunci2'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jadwalid'] = jadwalid;
    data['reqid'] = reqid;
    data['initial'] = initial;
    data['psnim'] = psnim;
    data['psname'] = psname;
    data['tanggal'] = DateTime.parse(tanggal!);
    data['mediapendampingan'] = mediapendampingan;
    data['katakunci'] = katakunci;
    data['katakunci2'] = katakunci2;

    return data;
  }
}