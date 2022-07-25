import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        leading: const Center(
          child: Text(
            'Back',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        centerTitle: true,
        title: SizedBox(
          width: 150,
          height: 75,
          child: Image.asset(
            'assets/images/amazon_prime_logo.jpg',
            color: Colors.black,
            // colorBlendMode: BlendMode.dstOut,
            colorBlendMode: BlendMode.colorBurn,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.refresh,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.black,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Create account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.black),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Your email address',
              hintStyle: TextStyle(color: Colors.black),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Create a password',
              hintStyle: TextStyle(color: Colors.black),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text.rich(
            TextSpan(children: <InlineSpan>[
              TextSpan(
                  text: ' i',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue)),
              WidgetSpan(
                child: SizedBox(
                  width: 5,
                ),
              ),
              TextSpan(
                  text: 'Passwords must be at least 6 characters',
                  style: TextStyle(color: Colors.white)),
            ]),
          ),
          const SizedBox(
            height: 25,
          ),
          Text.rich(
            TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                    value: true,
                    activeColor: Colors.white,
                    onChanged: (value) {}),
              )),
              const WidgetSpan(
                  child: SizedBox(
                width: 10,
              )),
              const WidgetSpan(
                child: Text(
                  'Show password',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue[400],
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
            ),
            onPressed: () {
              debugPrint('create your amazon account button Tap()');
            },
            child: const Center(
              child: Text(
                'Create Your Amazon account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text.rich(
            TextSpan(children: <InlineSpan>[
              TextSpan(
                text: 'By creating an account, you agree to the ',
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(
                text: 'Prime Video Terms of Use ',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text:
                    'and license agreements which can be found on the Amazon website',
                style: TextStyle(color: Colors.grey),
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Already have an account?',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(0.8),
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
            ),
            onPressed: () {
              debugPrint('create your amazon account button Tap()');
            },
            child: const Center(
              child: Text(
                'Sign-In now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const Flexible(
            fit: FlexFit.loose,
            child: Center(
              child: Text(
                '@ 1996-2021, Amazon.com, Inc. or its affiliates',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100,
              height: 5,
              margin: const EdgeInsets.only(
                bottom: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
