class Laporan {
  String? initial;
  String? psname;
  DateTime? tanggal;
  int? jadwalid;
  int? isRecommended;
  String? katakunci;
  String? gambaran;
  String? proses;
  String? hasil;
  String? kendala;
  int? isAgree;

  Laporan({
    this.initial,
    this.psname,
    this.tanggal,
    this.jadwalid,
    this.isRecommended,
    this.katakunci,
    this.gambaran,
    this.proses,
    this.hasil,
    this.kendala,
    this.isAgree
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      initial: json['initial'],
      psname: json['psname'],
      tanggal: json['tanggalKonversi'] != null ? DateTime.parse(json['tanggalKonversi']) : DateTime.now(),
      jadwalid: json['jadwalid'],
      isRecommended: json['isRecommended'],
      katakunci: json['katakunci'],
      gambaran: json['gambaran'],
      proses: json['proses'],
      hasil: json['hasil'],
      kendala: json['kendala'],
    );
  }
}


class Katakunci {
  String? katakunci;

  Katakunci({this.katakunci});

  Katakunci.fromJson(Map<String, dynamic> json) {
    katakunci = json['katakunci'];
  }
}