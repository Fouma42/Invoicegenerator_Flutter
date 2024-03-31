class Settings {
  final String steuernummer;
  final String nachName;
  final String name;
  final String strasse;
  final String hausnummer;
  final String plz;
  final String ort;
  final String iban;
  final String bic;
  final String websiteUrl;
  final String telefonNummer;
  final String email;

  Settings(
      {required this.steuernummer,
      required this.nachName,
      required this.name,
      required this.strasse,
      required this.hausnummer,
      required this.plz,
      required this.ort,
      required this.iban,
      required this.bic,
      required this.websiteUrl,
      required this.telefonNummer,
      required this.email});

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      steuernummer: map['steuernummer'],
      nachName: map['nachName'],
      name: map['name'],
      strasse: map['strasse'],
      hausnummer: map['hausnummer'],
      plz: map['plz'],
      ort: map['ort'],
      iban: map['iban'],
      bic: map['bic'],
      websiteUrl: map['websiteUrl'],
      telefonNummer: map['telefonNummer'],
      email: map['email'],
    );
  }
}
