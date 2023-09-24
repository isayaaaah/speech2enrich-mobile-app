import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech2enrich/score.dart';
import 'package:speech2enrich/storygame/advstory.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'package:speech2enrich/menu.dart';

import '../global.dart';

class storyinstruc extends StatefulWidget {
  const storyinstruc({Key? key}) : super(key: key);

  @override
  State<storyinstruc> createState() => _storyinstrucState();
}

class _storyinstrucState extends State<storyinstruc> {
  final List<String> _imgURL = [
    'assets/images/story1menu.png',
    'assets/images/story2menu.png',
    'assets/images/story3menu.png'
  ];

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        bgAudio1.pause();
        //playbgm2();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => story1()),
        );
        break;
      case 1:
        bgAudio1.pause();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => story2()),
        );
        break;
      case 2:
        bgAudio1.pause();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => story3()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/storyscreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 300, autoPlay: true, enlargeCenterPage: true),
                items: _imgURL.map((imagepath) {
                  return Builder(builder: (BuildContext context) {
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
          ),
        ],
      ),
    );
  }
}

/*
class startstory extends StatefulWidget {
  //const startstory({Key? key}) : super(key: key);

  @override
  State<startstory> createState() => _startstoryState();
}

class _startstoryState extends State<startstory> with TickerProviderStateMixin {

  final player=AudioPlayer();


  String scene1 = "Once upon a time, there was a curious little bear named Benny. One day, Benny decided to go on an adventure through the forest.";
  Color colorSpeak = Colors.red;


  Future<bool> _onWillPop() async {
    player.pause();
    return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  player.resume();
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),

            ),
            TextButton(
                onPressed: () {
                  player.stop();
                  Navigator.of(context).pop(true);

                },
                child: Text('Yes')
            )
          ],
        ))
    );
  }


  Timer? _timer;

  SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _text = '';
  int score = 0;
  String ear = 'assets/earoff.png';
  String yousaid = '';
  String background = "assets/images/story1images/scene1.gif";


  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
    player.play(AssetSource("shortmusic.mp3"));
    Timer(
      Duration(seconds: 4),() {
        setState(() {
          scene1 = "Benny walked along the path and saw beautiful flowers. He said, 'Flower' to himself as he admired it. Can you repeat after Benny, 'Flower' to make it bloom?";
        });
        print(score);
        Timer(
            Duration(seconds: 4),() {
          _startListeningFlower();
          setState(() {
            ear = 'assets/earon.png';

          });
          Timer(
            Duration(seconds: 7),(){
              setState(() {
                yousaid = 'You said: ';
                ear = 'assets/earoff.png';
                colorSpeak = Colors.red;
              });
            Timer(
              Duration(seconds: 4),(){
                setState(() {
                  _text = '';
                  yousaid = '';

                });

                Timer(Duration(seconds: 4),(){
                  setState(() {
                    scene1 = "Benny saw a squirrel gathering nuts. He said, 'Nuts' as he watched. Can you repeat after Benny, 'Nuts' to help the squirrel collect them?";
                    background = "assets/images/story1images/scene2.gif";
                  });
                  Timer(Duration(seconds: 4),(){
                    _startListeningNuts();
                    setState(() {
                      ear = 'assets/earon.png';
                    });
                    Timer(Duration(seconds: 7),(){
                      setState(() {
                        yousaid = 'You said: ';
                        ear = 'assets/earoff.png';
                        colorSpeak = Colors.red;
                      });
                      Timer(Duration(seconds: 4),() {
                        setState(() {
                          _text = '';
                          yousaid = '';

                        });
                        Timer(Duration(seconds: 4),(){
                          setState(() {
                            background = "assets/images/story1images/scene3.gif";
                            scene1 = "Benny came across a stream and saw a fish swimming. He said, 'Fish' as he watched. Can you repeat after Benny, 'Fish' to help it swim upstream?";
                          });
                          Timer(Duration(seconds: 4),(){
                            _startListeningFish();
                            setState(() {
                              ear = 'assets/earon.png';
                            });
                            Timer(Duration(seconds: 7),(){
                              setState(() {
                                yousaid = 'You said: ';
                                ear = 'assets/earoff.png';
                                colorSpeak = Colors.red;
                              });
                              Timer(Duration(seconds: 4),() {
                                setState(() {
                                  _text = '';
                                  yousaid = '';
                                });
                                Timer(Duration(seconds: 4),() {
                                  setState(() {
                                    background = "assets/images/story1images/scene4.gif";
                                    scene1 = "Benny saw a big, juicy apple hanging from a tree. He said, 'Big Apple' as he approached it. Can you repeat after Benny, 'Big Apple' to help him reach it?";
                                  });
                                  Timer(Duration(seconds: 4),() {
                                    _startListeningBigApple();
                                    setState(() {
                                      ear = 'assets/earon.png';
                                    });
                                    Timer(Duration(seconds: 7),() {
                                      setState(() {
                                        yousaid = 'You said: ';
                                        ear = 'assets/earoff.png';
                                        colorSpeak = Colors.red;
                                      });
                                      Timer(Duration(seconds: 4),() {
                                        setState(() {
                                          _text = '';
                                          yousaid = '';
                                        });
                                        Timer(Duration(seconds: 4),() {
                                          setState(() {
                                            background = "assets/images/story1images/scene5.gif";
                                            scene1 = "Benny saw a family of rabbits hopping around. He said, 'Hop Together' as he tried to join in. Can you repeat after Benny, 'Hop Together' to help him play with them?";
                                          });
                                          Timer(Duration(seconds: 4),() {
                                            _startListeningHopTogether();
                                            setState(() {
                                              ear = 'assets/earon.png';
                                            });
                                            Timer(Duration(seconds: 7),() {
                                              setState(() {
                                                yousaid = 'You said: ';
                                                ear = 'assets/earoff.png';
                                                colorSpeak = Colors.red;
                                              });
                                              Timer(Duration(seconds: 4),() {
                                                setState(() {
                                                  _text = '';
                                                  yousaid = '';
                                                });
                                                Timer(Duration(seconds: 4),() {
                                                  setState(() {
                                                    background = "assets/images/story1images/scene6.gif";
                                                    scene1 = "Benny saw a butterfly flying in the sky. He said, 'Pretty Butterfly' as he admired it. Can you repeat after Benny, 'Pretty Butterfly' to help it land on his nose?";
                                                  });
                                                  Timer(Duration(seconds: 4),() {
                                                    _startListeningPrettyButterfly();
                                                    setState(() {
                                                      ear = 'assets/earon.png';
                                                    });
                                                    Timer(Duration(seconds: 7),() {
                                                      setState(() {
                                                        yousaid = 'You said: ';
                                                        ear = 'assets/earoff.png';
                                                        colorSpeak = Colors.red;
                                                      });
                                                      Timer(Duration(seconds: 4),() {
                                                        setState(() {
                                                          _text = '';
                                                          yousaid = '';
                                                        });
                                                        Timer(Duration(seconds: 4),() {
                                                          setState(() {
                                                            background = "assets/images/story1images/scene7.gif";
                                                            scene1 = "Benny saw a snake slithering through the jungle and said, ""Slither, slither"" as he followed it. Can you repeat after Benny, ""Slither, slither"" to help him track the snake?";
                                                          });
                                                          Timer(Duration(seconds: 4),() {
                                                            _startListeningSlither();
                                                            setState(() {
                                                              ear = 'assets/earon.png';
                                                            });
                                                            Timer(Duration(seconds: 7),() {
                                                              setState(() {
                                                                yousaid = 'You said: ';
                                                                ear = 'assets/earoff.png';
                                                                colorSpeak = Colors.red;
                                                              });
                                                              Timer(Duration(seconds: 4),() {
                                                                setState(() {
                                                                  _text = '';
                                                                  yousaid = '';
                                                                });
                                                                Timer(Duration(seconds: 4),() {
                                                                  setState(() {
                                                                    background = "assets/images/story1images/scene8.gif";
                                                                    scene1 = "Benny saw a group of animals in a clearing. He said, ""Let's make friends with the animals"" as he walked over. Can you repeat after Benny, ""Let's make friends with the animals"" to help him make new friends?";
                                                                  });
                                                                  Timer(Duration(seconds: 4),() {
                                                                    _startListeningLetsMakeFriends();
                                                                    setState(() {
                                                                      ear = 'assets/earon.png';
                                                                    });
                                                                    Timer(Duration(seconds: 7),() {
                                                                      setState(() {
                                                                        yousaid = 'You said: ';
                                                                        ear = 'assets/earoff.png';
                                                                        colorSpeak = Colors.red;
                                                                      });
                                                                      Timer(Duration(seconds: 4),() {
                                                                        setState(() {
                                                                          _text = '';
                                                                          yousaid = '';
                                                                        });
                                                                        Timer(Duration(seconds: 4),() {
                                                                          setState(() {
                                                                            background = "assets/images/story1images/scene9.gif";
                                                                            scene1 = "Benny saw a dark cave and heard strange noises. He said, ""I'm not scared, I can explore the cave"" as he bravely walked in. Can you repeat after Benny, ""I'm not scared, I can explore the cave' to help him discover what's inside?""";
                                                                          });
                                                                          Timer(Duration(seconds: 4),() {
                                                                            _startListeningImNotScared();
                                                                            setState(() {
                                                                              ear = 'assets/earon.png';
                                                                            });
                                                                            Timer(Duration(seconds: 7),() {
                                                                              setState(() {
                                                                                yousaid = 'You said: ';
                                                                                ear = 'assets/earoff.png';
                                                                                colorSpeak = Colors.red;
                                                                              });
                                                                              Timer(Duration(seconds: 4),() {
                                                                                setState(() {
                                                                                  _text = '';
                                                                                  yousaid = '';
                                                                                });
                                                                                Timer(Duration(seconds: 4),() {
                                                                                  setState(() {
                                                                                    scene1 = "As Benny finished his adventure, he realized that repeating words and sentences can be a fun and helpful way to communicate with friends and explore the world around him.";
                                                                                  });
                                                                                  Timer(Duration(seconds: 4),(){
                                                                                    saveData();
                                                                                    Timer(Duration(seconds: 1),(){
                                                                                      //Navigator.pop(context);
                                                                                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => congratsScreen(score: score.toString(),)));
                                                                                    });

                                                                                  });
                                                                                });
                                                                              });
                                                                            });
                                                                          });
                                                                        });
                                                                      });
                                                                    });
                                                                  });
                                                                });
                                                              });
                                                            });
                                                          });
                                                        });
                                                      });
                                                    });
                                                  });
                                                });
                                              });
                                            });
                                          });
                                        });
                                      });
                                    });
                                  });
                                });
                              });
                            });
                          });
                        });
                      });
                    });
                  });
                });
            });
          });
        });
      }
    );
  }

  void saveData() async {
    print('test1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('sda' + score.toString());
    prefs.setInt("scoreKey", score);
    print('test2');
  }

  void _startListeningImNotScared() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String imnotscared = "I'm not scared I can explore the cave";
        print(splitText);
        if(_text == imnotscared){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said I'm not scared I can explore the cave.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningLetsMakeFriends() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String letsmake = "let's make friends with the animals";
        print(splitText);
        if(_text == letsmake){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said let's make friends with the animals.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningSlither() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String slither = "slither slither";
        print(splitText);
        if(_text == slither){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said Slither, Slither.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningPrettyButterfly() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String prettybutterfly = "pretty butterfly";
        print(splitText);
        if(_text == prettybutterfly){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said Pretty Butterfly.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningHopTogether() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String hoptogether = "hop together";
        print(splitText);
        if(_text == hoptogether){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said Hop Together.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningBigApple() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String bigapple = "big apple";
        print(splitText);
        if(_text == bigapple){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said Big Apple.";
          });
        }
        //if(splitText.any((element) => bigapple.contains(element))){}
        else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningFish() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String fish = "fish";
        print(splitText);
        if(splitText.any((element) => fish.contains(element)) && _text.isNotEmpty){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said fish.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningNuts() async {
    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {

        _stopListening();
        List<String> splitText = _text.split(' ');
        String nuts = "nuts";
        print(splitText);
        if(splitText.any((element) => nuts.contains(element)) && _text.isNotEmpty){
          score = score + 5;
          setState(() {
            scene1 = "Yes, that is correct! You said nuts.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListeningFlower() async {
    bool emptyStr = false;

    bool isAvailable = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (isAvailable) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },

      );

      Timer(Duration(seconds: 7), () {
        _stopListening();
        List<String> splitText = _text.split(' ');
        String flower = "flower";
        print(splitText);
        if(splitText.any((element) => flower.contains(element)) && _text.isNotEmpty){
          score = score + 10;
          setState(() {
            scene1 = "Yes, that is correct! You said Flower.";
          });
        }else if (_text.isEmpty){
          setState(() {
            scene1 = "You said nothing";
          });
          score = score + 0;
        }else{
          score = score + 0;
          setState(() {
            scene1 = "No, that is wrong. You said " + _text;
          });
        }
        print(_text);
        print(score);

      });
    } else {
      print('Speech recognition not available');
    }
  }

  void _stopListening() {
    _speech.stop();

    setState(() {
      _isListening = false;
    });
  }


  static const colorizeColors = [
    Colors.white,
    Colors.yellow,

  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 12.0,
  );


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                image: AssetImage(background),
                fit: BoxFit.cover, // set the image scaling mode
              ),
            ),
            Positioned(
              left: 20,
              bottom: 0,
              child: Image.asset(
                  'assets/images/story1char.png',
                  fit: BoxFit.cover,
                  height: 190
              ),
            ),
            Positioned(
              top: 8,
              right: 15,
              child: SafeArea(
                child: Image.asset(
                    ear,
                    fit: BoxFit.cover,
                    height: 60
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              child: SafeArea(
                child: Container(
                  width: 100,
                  height: 30,
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Text('Score: '+score.toString())),
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Text(yousaid + _text,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
                ),
                ),
              ),
            ),

            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(scene1,style: TextStyle(color: Colors.grey),),
                  margin: EdgeInsets.only(bottom: 20),
                  width: 500,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.7),

                  ),
                )
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.yellow
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(scene1,speed: Duration(milliseconds: 100),)
                      ],

                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                  width: 500,
                  height: 75,

                )
            ),



          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();

    super.dispose();
  }

}

class congratsScreen extends StatefulWidget {
  //const congratsScreen({Key? key}) : super(key: key);

  congratsScreen({required this.score});
  String score;

  @override
  State<congratsScreen> createState() => _congratsScreenState();
}

class _congratsScreenState extends State<congratsScreen> {

  double _paddingPlay = 6.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/storyscreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Image.asset(
                'assets/images/storyscoreboard.png',
                width: 320,

              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Congratulations!',style: TextStyle(
                      fontSize: 30,
                    ),),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text('Your Score: ${widget.score}'),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTapDown: (_) =>
                            setState(() {
                              _paddingPlay = 0.0;
                            }),
                        onTapUp: (_) =>
                            setState(() {
                              _paddingPlay = 6.0;
                            }),
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.only(bottom: _paddingPlay),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            child: Text('HOME',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  } 
}
*/







