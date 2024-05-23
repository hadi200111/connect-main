import 'package:CampusConnect/Locale/locale_controller.dart';
import 'package:CampusConnect/UserPage/ChangePasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  String selectedLanguage = 'English';
  bool areNotificationsEnabled = true;
  bool isAutoSaveEnabled = false;
  bool isLocationEnabled = true;
  double fontSize = 16;

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLang = Get.find();
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.deepPurple.shade600 ,
        title: Text(
          'Settings',
          style: TextStyle(
            color:Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.dark_mode_outlined,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Dark Mode'),
                subtitle: Text('Enable or disable dark mode'),
                trailing: Switch(
                  value: isDarkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      isDarkModeEnabled = value;
                      // Perform action to change theme to dark mode
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.language_outlined,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Language'),
                subtitle: DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                      if (selectedLanguage == 'Arabic') {
                        controllerLang.changeLanguage("ar");
                      // } else if (selectedLanguage == 'French') {
                      //   controllerLang.changeLanguage("fr");
                      } else {
                        controllerLang.changeLanguage("en");
                      }
                    });
                  },
                  items: ['English', 'Arabic', 'Spanish', 'French'].map((key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key.tr),
                    );
                  }).toList(),
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Notifications'),
                subtitle: Text('Allow Notifications'),
                trailing: Switch(
                  value: areNotificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      areNotificationsEnabled = value;
                      // Perform action to enable or disable notifications
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.save_sharp,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Auto Save'),
                subtitle: Text('Enable or disable auto save feature'),
                trailing: Switch(
                  value: isAutoSaveEnabled,
                  onChanged: (value) {
                    setState(() {
                      isAutoSaveEnabled = value;
                      // Perform action to enable or disable auto save feature
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on_sharp,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Location'),
                subtitle: Text('Enable or disable location services'),
                trailing: Switch(
                  value: isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isLocationEnabled = value;
                      // Perform action to enable or disable location services
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.text_fields,
                  color: Colors.deepPurple.shade400,
                  size: 30,
                ),
                title: Text('Font Size: ${fontSize.toInt()}'),
                subtitle: Slider(
                  value: fontSize,
                  min: 12,
                  max: 24,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      fontSize = value;
                      // Perform action to change font size
                    });
                  },
                ),
              ),
              SizedBox(height: 20), // Add some space above the button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                    );
                  },
                  icon: Icon(Icons.lock_outline),
                  label: Text('Change Password'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepPurple.shade400, // Text color
                  ),
                ),
              ),
              SizedBox(height: 20), // Add some space below the button if needed
              // Add more settings as needed
            ],
          ),
        ),
      ),
    );
  }
}
