import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Weatherapp extends StatelessWidget {
  const Weatherapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("wheather app")),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
       children: [
         TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "enter city name",
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Provider.fetchweather(controller.text);
              },
              ),
          ),
         ),
         const SizedBox(height: 20),
         if (Provider.isLoading)
            
         const CircularProgressIndicator(),

         if (Provider.error != null);
         Text(Provider.error!,style: const TextStyle(color: Colors.red)),
                    
         if (Provider.weather != null)
         Column(
          children: [
            Text(
              Provider.weather!.city,
              style:const Textstyle(fontsize:22),
               ),
               Text("${Provider.weather!.temp} C"),
               Text("${Provider.weather!.condition}"),
               Text("Humidity:${Provider.weather!.humidity}%"),
               Text("Wind:${Provider.weather!.wind}kph"),
          ],
         )
       ], 
      ),
      ),
    );
  }
}