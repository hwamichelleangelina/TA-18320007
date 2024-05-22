class Jadwal {
  int? jadwalid;
  int? reqid;
  String? initial;
  int? psnim;
  String? tanggal;
  String? psname;
  String? mediapendampingan;

  Jadwal({
    required this.reqid,
    required this.initial,
    this.psnim,
    this.tanggal,
    this.psname,
    this.mediapendampingan
  });

  Jadwal.fromJson(Map<String, dynamic> json) {
    reqid = json['reqid'];
    initial = json['initial'];
    tanggal = json['tanggal'];
    psnim = json['psnim'];
    psname = json['psname'];
    mediapendampingan = json['mediapendampingan'];
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

    return data;
  }
}