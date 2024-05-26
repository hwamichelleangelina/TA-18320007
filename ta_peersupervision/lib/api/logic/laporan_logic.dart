class Laporan {
  int? reportid;
  int? jadwalid;
  int? reqid;
  String? initial;
  int? psnim;
  DateTime? tanggal;
  String? psname;
  int? isRecommended;
  String? katakunci;
  String? gambaran;
  String? proses;
  String? hasil;
  String? kendala;
  int? isAgree;

  Laporan({
    this.reportid,
    this.jadwalid,
    this.reqid,
    this.initial,
    this.psnim,
    this.tanggal,
    this.psname,
    this.gambaran,
    this.proses,
    this.kendala,
    this.hasil,
    this.isRecommended,
    this.isAgree,
  });

  Laporan.fromJson(Map<String, dynamic> json) {
    reportid = json['reportid'];
    jadwalid = json['jadwalid'];
    reqid = json['reqid'];
    initial = json['initial'];
    tanggal = DateTime.parse(json['tanggal']);
    psnim = json['psnim'];
    psname = json['psname'];
    isRecommended = json['isRecommended'];
    katakunci = json['katakunci'];
    gambaran = json['gambaran'];
    proses = json['proses'];
    hasil = json['hasil'];
    kendala = json['kendala'];
    isAgree = json['isAgree'];
  }
}

class Katakunci {
  String? katakunci;

  Katakunci({this.katakunci});

  Katakunci.fromJson(Map<String, dynamic> json) {
    katakunci = json['katakunci'];
  }
}