import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:register/url.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isvalid = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  Future<void> registeruser() async {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      var registerbody = {
        "email": _email.text,
        "password": _password.text,
      };
      var response = await http.post(
        Uri.parse(register_url),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode(registerbody),
      );
      var jsonresponse = jsonDecode(response.body);

      if (jsonresponse["email"] == _email.text) {
        print("User Registered");
      } else {
        print("User Not Registered");
      }
    } else {
      setState(() {
        isvalid = false;
      });
    }
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Enter your email ",
                      errorText: isvalid ? null : "invalid email",
                      errorStyle: TextStyle(color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      hintText: "Enter your Password ",
                      errorText: isvalid ? null : "invalid password",
                      errorStyle: TextStyle(color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
