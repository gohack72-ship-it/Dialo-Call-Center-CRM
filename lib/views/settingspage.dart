import 'package:dialo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDrawer extends StatefulWidget {
  final Function(bool)changeTheme;
  const SettingsDrawer({super.key,required this.changeTheme});
  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();

  static Widget _item(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon,
        size: 22,
          // color: AppColors.textColor
      ),
      title: Text(title),
      onTap: () {},
    );
  }
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool isDarkMode = false;

  @override
  void initState(){
    super.initState();
    loadTheme();
  }

  void loadTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void saveTheme(bool value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", value);
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        // color: Colors.black
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            const ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.themeColor,
                child: Icon(
                  Icons.person_outline,
                  color:AppColors.textColor ,
                  size: 28,
                ),
              ),

              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ),
            SizedBox(height: 10),
            const Divider(),
            SettingsDrawer._item("Notifications", Icons.notifications,),
           ListTile(
             leading: const Icon(
                 Icons.dark_mode,
                 size: 22,
               // color: AppColors.textColor,
             ),
             title: const Text("Mode Change"),
             trailing: Switch(value: isDarkMode,
                 activeColor: AppColors.themeColor,
                 onChanged: (value){
               setState((){
                 isDarkMode=value;
               });
               widget.changeTheme(value);
                 }),
           ),
            SettingsDrawer._item("Help & About", Icons.help),
            SettingsDrawer._item("Logout", Icons.logout),
          ],
        ),
      ),
    );
  }
}
