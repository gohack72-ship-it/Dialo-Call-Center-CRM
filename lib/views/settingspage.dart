import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsDrawer extends StatefulWidget {
  final Function(bool) changeTheme;
  const SettingsDrawer({super.key, required this.changeTheme});
  // sharedPreferences prefs = await SharedPreferences.getInstance();
  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
  // prefs.setString("userName", userData['NAME']);
  // prefs.setString?("UserImage", userDate['IMAGE']);

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

String userName = '';
String userImage = '';

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;

      // userName = prefs.getString("userName") ?? "Profile";
      //
      // userImage = prefs.getString("userImage") ?? '';

      userName = prefs.getString("name") ?? "Profile";

      userImage = prefs.getString("image") ?? '';
     });
    print(userName);
    print(userImage);

  }

  void saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", value);
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("No"),
            ),
TextButton(
  onPressed: () async {
    Navigator.pop(dialogContext);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginpage(changeTheme: widget.changeTheme)), (route) => false);
  },
  child: const Text("Yes"),
),
          ],
        );
      },
    );
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
             ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.themeColor,

                backgroundImage: userImage.isNotEmpty
                                ? NetworkImage(userImage)
                                 : null,
                child: userImage.isEmpty
                   ? const Icon(
                  Icons.person_outline,
                  color: AppColors.textColor,
                  size: 28,

              )
              : null,
              ),

              title: Text(
                userName,
                style: TextStyle(
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 22
                ),
              ),
               subtitle: Text("Agent"),
            ),

             // ),
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
                 activeThumbColor: AppColors.themeColor,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  widget.changeTheme(value);
                },
              ),
            ),
SettingsDrawer._item("Help & About", Icons.help),
ListTile(
  leading:  Icon(
      Icons.logout, size: 22,
      color: Theme.of(context).iconTheme.color,
      // AppColors.textColor
  ),
  title: const Text("Logout"),
  onTap: () {
    showLogoutDialog(context);
  },
),
          ],
        ),
      ),
    );
  }
}



