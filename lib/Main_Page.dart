import 'package:CampusConnect/UserPage/ToDoList.dart';
import 'package:CampusConnect/WelocomeLogIn/About.dart';
import 'package:CampusConnect/Calendar/CalendarPage.dart';
import 'package:CampusConnect/Library/LibraryPage.dart';
import 'package:CampusConnect/ChatSystem/MessagesPage.dart';
import 'package:CampusConnect/ChatSystem/NotificationsPage.dart';
import 'package:CampusConnect/PostWidget.dart';
import 'package:CampusConnect/UserPage/ProfilePage.dart';
import 'package:CampusConnect/UserPage/SettingsPage.dart';
import 'package:CampusConnect/WelocomeLogIn/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:CampusConnect/Posts.dart';
import 'package:CampusConnect/Library/PrevoisMaterial.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';




List<Posts> posts = [
  Posts(
    userName: 'Hadi',
    userImageUrl: 'https://picsum.photos/250?image=9',
    postImageUrl: 'https://picsum.photos/250?image=9',
    caption: 'ضيعت شنتتي في المجمع, حدا شافها؟',
    likeCounter: 0,
  ),
  // Add more posts as needed
];

class Main_Page extends StatefulWidget {
  const Main_Page({Key? key}) : super(key: key);

  @override
  Main_PageState createState() => Main_PageState();
}

class Main_PageState extends State<Main_Page> {
  int currentPage = 2;

  final List<Widget> _pages = [
    CalendarPage(),
    ProfilePage(),
    MainHomePage(),
    MessagesPage(),
    NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("1".tr),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [Colors.deepPurpleAccent, Colors.purple])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome', // First text
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8), // Adding some space between texts
                    Text(
                      'UserName', // Second text
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.calendar_month_outlined,
                title: 'Calendar',
                onTap: () => _navigateToPage(CalendarPage()),
              ),
              _buildDrawerItem(
                icon: Icons.book_online_sharp,
                title: 'Library',
                onTap: () => _navigateToPage(LibraryPage()),
              ),
              _buildDrawerItem(
                icon: Icons.library_books_outlined,
                title: 'Previous Material',
                onTap: () => _navigateToPage(PreviousMaterial()),
              ),
              _buildDrawerItem(
                icon: Icons.person,
                title: 'Profile',
                onTap: () => _navigateToPage(ProfilePage()),
              ),
              _buildDrawerItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () => _navigateToPage(NotificationsPage()),
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => _navigateToPage(SettingsPage()),
              ),
              _buildDrawerItem(
                icon: Icons.login,
                title: 'LogIn',
                onTap: () => _navigateToPage(WelcomePage()),
              ),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'LogOut',
                onTap: () => _navigateToPage(WelcomePage()),
              ),
              _buildDrawerItem(
                icon: Icons.info,
                title: 'About',
                onTap: () => _navigateToPage(AboutPage()),

              ),
              _buildDrawerItem(
                icon: Icons.view_timeline_outlined,
                title: 'ToDoList',
                onTap: () => _navigateToPage(ToDoList()),
              ),
            ],
          ),
        ),
        body: _pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
          ],
          backgroundColor: Colors.deepPurpleAccent, // Background color of the navigation bar
          selectedItemColor: Colors.deepPurple.shade700, // Color of the selected item
          unselectedItemColor: Colors.grey.shade700, // Color of the unselected items
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
        required String title,
        required void Function() onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostWidget(
              post: posts[index],
            );
          },
        ),
      ],
    );
  }
}
