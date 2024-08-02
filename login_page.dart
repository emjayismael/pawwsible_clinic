import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:my_first_app/db_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File? _image;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }
  
  Future<bool> verifyPassword(String hashedPassword) async {
    return await FlutterBcrypt.verify(password: _passwordController.text, hash: hashedPassword);
  }

  Future<List> login() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.connect();
    // await dbHelper.seedDatabase();
    final conn = dbHelper.connection;

    var results = await conn!.query('SELECT * FROM user WHERE username= ?', [_usernameController.text]);
    List rows = results.map((row) => row.fields).toList();
    if (rows.isNotEmpty) {
      if (await verifyPassword(rows[0]['password'].toString())) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('username', rows[0]['username']);
        sharedPreferences.setString('role', rows[0]['role']);
        if (rows[0]['role'].toString() == 'Admin') Navigator.pushReplacementNamed(context, '/adminDashboard');
        else if (rows[0]['role'].toString() == 'Customer') Navigator.pushReplacementNamed(context, '/dashboard');
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Invalid Credentials'
            )
          ));
        }
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Invalid Credentials'
        )
      ));
    }

    // print(results);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   behavior: SnackBarBehavior.floating,
    //   content: Text(
    //     results
    //   )
    // ));

    return [];
  }

  void _navigateToDashboard() {
    // final String username = _usernameController.text;
    // final String password = _passwordController.text;

    // if (username == 'admin' && password == 'password123') {
    //   Navigator.pushReplacementNamed(context, '/adminDashboard');
    // } else if (username == 'user' && password == 'userpass') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Invalid username or password')),
    //   );
    // }
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F0FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20.0),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: _image == null
                          ? Image.network(
                              'https://cdn-icons-png.flaticon.com/512/616/616408.png',
                              width: 50,
                            )
                          : Image.file(
                              _image!,
                              width: 50,
                            ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pawssible',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF6A1B9A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A1B9A),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: _navigateToSignUp,
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Color(0xFF6A1B9A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '🐾 Welcome to Pawssible!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
