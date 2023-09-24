import 'package:flutter/material.dart';

class instructadv extends StatelessWidget {
  const instructadv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/tutorial01.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Say the correct phrase when the ear appears.'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class instructmemory extends StatelessWidget {
  const instructmemory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/tutorial02.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Say the number of the card you want to flip and match.'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

