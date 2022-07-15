import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: const Icon(
          Icons.arrow_back_ios,
        ),
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        color: const Color.fromRGBO(19, 19, 19, 1.0),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(38, 38, 38, 1.0),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.white),
                  label: Text('Email'),
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(38, 38, 38, 1.0),
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.white),
                label: Text('Password'),
                labelStyle: TextStyle(color: Colors.white),
              ),
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                debugPrint('Sign In button Tap()');
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                debugPrint('Recover Password button Tap()');
              },
              child: const Text(
                'Recover Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
