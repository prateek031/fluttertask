import 'package:appsteantask/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class User {
  final String name;
  final String username;
  final int id;
  final String password;
  final String image;

  User({
    required this.name,
    required this.username,
    required this.id,
    required this.password,
    required this.image,
  });
}

class Loginpage extends StatelessWidget {
  const Loginpage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<User> users = [
    User(
      name: 'Prateek Chourasiya',
      username: 'prateek',
      id: 1,
      password: 'aa',
      image:
          'https://img.freepik.com/free-photo/fashion-portrait-young-caucasian-man-handsome-model-casual-clothes-posing-studio-attractive-male_158538-13559.jpg?t=st=1713906097~exp=1713909697~hmac=a9e5b390218547e18fef8e50467f749371bb1054edee53cda9838dcf3506c92b&w=360',
    ),
    User(
      name: 'Test User',
      username: 'a',
      id: 1,
      password: 'cc',
      image:
          'https://img.freepik.com/free-photo/portrait-handsome-serious-hipster-businessman-model-wearing-casual-black-suit_158538-973.jpg?t=st=1713906131~exp=1713909731~hmac=5514f9668e0eaefb4a0949aa23484745a8db9ac64f6619ad2a07958c6c72fdc5&w=740',
    ),
    User(
      name: 'Anuj Singh',
      username: 'anuj6963',
      id: 2,
      password: 'aaa',
      image:
          'https://img.freepik.com/free-photo/portrait-young-man-yellow-scene_23-2148184711.jpg?t=st=1713906149~exp=1713909749~hmac=26d416973885197c3c33df16ecfb613e713c7ea30d7db9567a5e19c59f5b04d8&w=360',
    ),
    User(
      name: 'Jai Soni',
      username: 'jaiho69',
      id: 3,
      password: 'sss',
      image: 'https://img.freepik.com/free-photo/portrait-sexy-handsome-fashion-male-model-man-dressed-elegant-suit-posing-street-background-blue-sky_158538-9192.jpg?t=st=1713906175~exp=1713909775~hmac=42b8500540eeba29e3544f534b29ac7455b4a94f1c83fcdce24f0e4c8f1e8c27&w=360',
    ),
    User(
      name: 'Anushka Jain',
      username: 'anu12',
      id: 4,
      password: '123',
      image: 'https://img.freepik.com/free-photo/young-woman-sunglasses-hat-black-leather-jacket-posing-outdoor_231208-13405.jpg?t=st=1713906256~exp=1713909856~hmac=e16a4afa5dc2af2c729d306daf2e5d4df31ae94115aec20d16a27850dfb2853f&w=360',
    ),
    User(
      name: 'Rashi Modi',
      username: 'rashicooker43',
      id: 5,
      password: '1234',
      image: 'https://img.freepik.com/free-photo/portrait-young-happy-woman-studio_1303-13799.jpg?t=st=1713906214~exp=1713909814~hmac=a6bb963925289435a73859bdef1a63b21d5640f528b49e9fb062800d45609a3a&w=360',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          'https://img.freepik.com/free-vector/login-concept-illustration_114360-757.jpg?t=st=1713862529~exp=1713866129~hmac=c352bdd15f006061c63014d3bbf1c78fd919b715be35d00bf5aaf0e8bd8a8815&w=740',
          height: 250,
          width: 250,
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            String username = _usernameController.text;
            String password = _passwordController.text;

            User? user =
                users.firstWhereOrNull((user) => user.username == username);

            if (user != null && user.password == password) {
              Get.offAll(dashboard(
                name: user.name,
                username: user.username,
                id: user.id,
                image: user.image,
              ));
              print('Login successful');
            } else {
              print('Invalid credentials');
            }
          },
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
