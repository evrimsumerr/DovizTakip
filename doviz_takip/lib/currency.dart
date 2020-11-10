class currency{
  final String dolarAlis;
  final String dolarSatis;
  final String euroAlis;
  final String euroSatis;
  final String altinAlis;
  final String altinSatis;
  final String date;

  currency({this.dolarAlis,this.dolarSatis,this.euroAlis,this.euroSatis,this.altinAlis,this.altinSatis,this.date});

  factory currency.createJson(Map<String,dynamic> json){
  return currency(
    dolarAlis: json["ABD DOLARI"]["AlÄ±Å"],
    dolarSatis: json["ABD DOLARI"]["SatÄ±Å"],
    euroAlis: json["EURO"]["AlÄ±Å"],
    euroSatis: json["EURO"]["SatÄ±Å"],
    altinAlis: json["Gram AltÄ±n"]["AlÄ±Å"],
    altinSatis: json["Gram AltÄ±n"]["SatÄ±Å"],
    date: json["GÃ¼ncelleme Tarihi"]
  );
  }
}