import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech2enrich/score.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:speech2enrich/storygame/advstory.dart';
import 'package:speech2enrich/storygame/flipgame.dart';
import 'package:speech2enrich/storygame/learnabc.dart';
import 'package:speech2enrich/storygame/storyinstruc.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'global.dart';

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  final List<String> _imgURL = [
    'assets/storymenu.jpg',
    'assets/memorymenu.jpg',
    'assets/abcmenu.jpg'
  ];

  void initState() {
    BackButtonInterceptor.add(myInterceptor);
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => storyinstruc()),
        );
        break;
      case 1:
        bgAudio1.pause();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlipCardMemoryGameEasy()),
        );
        break;
      case 2:
        bgAudio1.pause();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => learnabc()),
        );
        break;
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    bgAudio1.resume();
    player.stop();
    bgAudio2.stop();

    return false; // return true if u want to stop back
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/menuscreen.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          margin: EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => storymenu()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/menustory.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => memorymenu()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/menumemory.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => learnabc()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/menuabc.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 5,
            right: 10,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenAdventure()));
                },
                child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/score.png')),
              ),
            ))
        /*SafeArea(
              child: Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true
                  ),
                  items: _imgURL.map((imagepath){
                    return Builder(
                        builder: (BuildContext context){
                          int index = _imgURL.indexOf(imagepath);
                          return GestureDetector(
                            onTap: () => _navigateToScreen(index),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(imagepath),
                            ),
                          );
                        });
                  }).toList(),
                ),
              ),
            ),*/
      ],
    ));
  }
}
