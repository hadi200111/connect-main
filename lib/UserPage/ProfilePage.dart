import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitch = false;
  bool? isChecked = false;
  late String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String imagePath = appDirectory.path + '/profile_image.jpg';

    if (File(imagePath).existsSync()) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickedFile = await _picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     final Directory appDirectory = await getApplicationDocumentsDirectory();
  //     final String newPath = appDirectory.path + '/profile_image.jpg';
  //     final File newImage = await File(pickedFile.path).copy(newPath);
  //
  //     setState(() {
  //       _imagePath = newImage.path;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                         // _pickImage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: _imagePath.isNotEmpty
                              ? FileImage(File(_imagePath))
                              : null,
                          child: _imagePath.isEmpty
                              ? Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'User Name',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'ID: 12345',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Major: Computer Science',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'LinkedIn: linkedin.com/in/user-name', // Add LinkedIn link here
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Edit Profile');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Switch(
                value: isSwitch,
                onChanged: (value) {
                  setState(() {
                    isSwitch = value;
                  });
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ),
            const Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
