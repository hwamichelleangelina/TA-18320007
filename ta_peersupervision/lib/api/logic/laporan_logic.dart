import 'package:intl/intl.dart';

class Laporan {
  String? initial;
  String? psname;
  DateTime? tanggal;
  int? jadwalid;
  int? isRecommended;
  String? katakunci;
  String? katakunci2;
  String? gambaran;
  String? proses;
  String? hasil;
  String? kendala;
  int? isAgree;
  DateTime? tanggalKonversi;

  Laporan({
    this.initial,
    this.psname,
    this.tanggal,
    this.jadwalid,
    this.isRecommended,
    this.katakunci,
    this.katakunci2,
    this.gambaran,
    this.proses,
    this.hasil,
    this.kendala,
    this.tanggalKonversi,
    this.isAgree,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      initial: json['initial'],
      psname: json['psname'],
      tanggal: DateTime.parse(json['tanggal']),
      tanggalKonversi: DateTime.parse(json['tanggalKonversi']),
      jadwalid: json['jadwalid'],
      isRecommended: json['isRecommended'],
      katakunci: json['katakunci'],
      katakunci2: json['katakunci2'],
      gambaran: json['gambaran'],
      proses: json['proses'],
      hasil: json['hasil'],
      kendala: json['kendala'],
      isAgree: json['isAgree'],
    );
  }

  String get formattedTanggal {
    final DateFormat formatter = DateFormat('d MMMM y', 'id');
    return formatter.format(tanggalKonversi!);
  }
}


class Katakunci {
  String? katakunci;
  String? katakunci2;

  Katakunci({this.katakunci, this.katakunci2});

  Katakunci.fromJson(Map<String, dynamic> json) {
    katakunci = json['katakunci'];
    katakunci2 = json['katakunci2'];
  }
}