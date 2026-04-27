class weathermodel{
final String city;
final double temp;
final String condition;
final int humidity;
final double wind;



weathermodel({
    required this.city,
    required this.temp,
    required this.condition,
    required this.humidity,
    required this.wind,
});
factory weathermodel.fromjson(Map<String,dynamic>json){
     return weathermodel(
    city: json["location"]["name"], 
    temp: json["current"]["temp_c"],
     condition: json["current"]["condition"],
      humidity: json["humidity"]["condition"]["text"],
       wind: json["current"]["wind_kph"],
     );
}
}


