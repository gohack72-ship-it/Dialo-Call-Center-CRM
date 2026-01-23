import 'package:flutter/material.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined),
        ),

        title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,),),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () {
                // Print("Set reminder cliked");
              },

              icon: Icon(Icons.notifications_active_outlined,color:Colors.white),

              label: Text("Set reiminder",style: TextStyle(color: Colors.white),

              ),
              style: TextButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

            ),

          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit_note_rounded,size: 30),
            ),
          ),

        ],
        bottom:PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Divider(
                color: Colors.grey,
                thickness: 1,

              ),
            )
    ) ,
      ),
      body: Padding(
    padding: const EdgeInsets.only(top: 10),
    ),
    );
  }
}
