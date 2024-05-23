import 'package:animate_do/animate_do.dart';
import 'package:CampusConnect/WelocomeLogIn/About.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    )
);

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _keepLoggedIn = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;
      if (_keepLoggedIn) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('keepLoggedIn', _keepLoggedIn);
    if (_keepLoggedIn) {
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.deepPurple.shade700,
                    Colors.deepPurpleAccent,
                    Colors.purple.shade300
                  ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
                    SizedBox(height: 10,),
                    FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                              ),
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    hintText: "UserName",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _keepLoggedIn,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _keepLoggedIn = newValue!;
                              });
                              _saveCredentials();
                            },
                          ),
                          Text("Remember Me", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 20,),
                      FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 40,),
                      FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                        onPressed: () {
                          // Add login logic here
                          _saveCredentials();
                        },
                        height: 50,
                        color: Colors.deepPurple[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      )),
                      SizedBox(height: 50,),
                      FadeInUp(duration: Duration(milliseconds: 1700), child: Text("Continue with Ritaj", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeInUp(duration: Duration(milliseconds: 1800), child: MaterialButton(
                              onPressed: () {
                                const url = 'https://ritaj.birzeit.edu/register/';
                                launch(url);
                              },
                              height: 50,
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text("Ritaj", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AboutPage()),
                                );
                              },
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: Colors.black,
                              child: Center(
                                child: Text("VisitorPick", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
