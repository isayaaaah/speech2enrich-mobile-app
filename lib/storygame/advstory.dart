import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech2enrich/storygame/instruct.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class storymenu extends StatefulWidget {
  const storymenu({Key? key}) : super(key: key);

  @override
  State<storymenu> createState() => _storymenuState();
}

class _storymenuState extends State<storymenu> {
  final List<String> _imgURL = [
    'assets/images/story1menu.png',
    'assets/images/story2menu.png',
    'assets/images/story3menu.png'
  ];

  void initState() {
    BackButtonInterceptor.add(myInterceptor);
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        bgAudio1.pause();
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
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    bgAudio1.resume();

    return false; // return true if u want to stop back
  }

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
          SafeArea(
            child: Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => instructadv()));
                },
                child: Container(
                  height: 70,
                    width: 70,
                    child: Image.asset('assets/images/btn.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class story1 extends StatefulWidget {
  const story1({Key? key}) : super(key: key);

  @override
  State<story1> createState() => _story1State();
}

class _story1State extends State<story1> {
  //String scene = 'Once upon a time, there was a curious little bear named Benny. One day, Benny decided to go on an adventure through the forest.';
  SpeechToText _speech = SpeechToText();
  bool displayEar = false;
  bool _isListening = false;
  String _text = '';
  int score = 0;
  Timer? _timer;
  bool isRight = false;
  bool isWrong = false;
  String background = 'assets/images/story1images/scene1.gif';

  bool dialogue1 = true;
  bool dialogue2 = true;
  bool dialogue3 = true;
  bool dialogue4 = true;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    player.play(AssetSource("musics/story1first.mp3"));
    Timer(Duration(milliseconds: 11000), () {
      //displayEar = true;
      player.play(AssetSource("musics/story1third.mp3"));
      Timer(Duration(milliseconds: 13000), () {
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000), () {
          player.play(AssetSource("musics/story1second.mp3"));
          setState(() {
            background = 'assets/images/story1images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/
        });
      });
    });

    super.initState();
  }

  void scene1st() {
    player.play(AssetSource("musics/story1first.mp3"));
    Timer(Duration(milliseconds: 11000), () {
      //displayEar = true;
      player.play(AssetSource("musics/story1third.mp3"));
      Timer(Duration(milliseconds: 13000), () {
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000), () {
          player.play(AssetSource("musics/story1second.mp3"));
          setState(() {
            background = 'assets/images/story1images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/
        });
      });
    });
  }

  void scene2nd() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningNuts();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1fourth.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene3.gif';
          isRight = false;
          isWrong = false;
        });
        scene3rd();
        /*Timer(Duration(milliseconds: 1000),() {
          scene3rd();
        });*/
      });
    });
  }

  void scene3rd() {
    Timer(Duration(milliseconds: 11000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningFish();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1fifth.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene4.gif';
          isRight = false;
          isWrong = false;
        });
        scene4th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene4th();
        });*/
      });
    });
  }

  void scene4th() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningBigApple();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1sixth.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene5.gif';
          isRight = false;
          isWrong = false;
        });
        scene5th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene5th();
        });*/
      });
    });
  }

  void scene5th() {
    Timer(Duration(milliseconds: 13000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningHopTogether();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1seventh.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene6.gif';
          isRight = false;
          isWrong = false;
        });
        scene6th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene6th();
        });*/
      });
    });
  }

  void scene6th() {
    Timer(Duration(milliseconds: 13000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningPrettyButterfly();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1eight.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene7.gif';
          isRight = false;
          isWrong = false;
        });
        scene7th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene7th();
        });*/
      });
    });
  }

  void scene7th() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
        // scene = '';
      });
      _startListeningSlither();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1ninth.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene8.gif';
          isRight = false;
          isWrong = false;
        });
        scene8th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene8th();
        });*/
      });
    });
  }

  void scene8th() {
    Timer(Duration(milliseconds: 15000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningLetsMakeFriends();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1tenth.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
        scene9th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene9th();
        });*/
      });
    });
  }

  void scene9th() {
    Timer(Duration(milliseconds: 17000), () {
      setState(() {
        displayEar = true;
        //scene = '';
      });
      _startListeningImNotScared();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story1eleventh.mp3"));
        setState(() {
          background = 'assets/images/story1images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
      });
    });
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
        if (_text == imnotscared) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (_text == letsmake) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (_text == slither) {
          score = score + 15;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (_text == prettybutterfly) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (_text == hoptogether) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (_text == bigapple) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }
        //if(splitText.any((element) => bigapple.contains(element))){}
        else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (splitText.any((element) => fish.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (splitText.any((element) => nuts.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        if (splitText.any((element) => flower.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();
    _speech.stop();

    super.dispose();
  }

  void saveData() async {
    print('test1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('sda' + score.toString());
    prefs.setInt("scoreKeyStory1", score);
    print('test2');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();

        return true;
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage(background),
              fit: BoxFit.cover, // set the image scaling mode
            ),
          ),
          Positioned(
            left: 30,
            bottom: 20,
            child: Image.asset('assets/images/story1char.png',
                fit: BoxFit.cover, height: 190),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(color: Colors.grey),
                ),
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                ),
              )),
          /*Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(scene,style: TextStyle(color: Colors.grey,fontSize: 16),),

                  width: double.infinity,
                  height: 75,

                )
            ),*/
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.yellow, fontSize: 16),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("_",
                          speed: Duration(milliseconds: 10)),
                      TypewriterAnimatedText(
                          "Once upon a time, there was a curious little bear named Benny. One day, Benny decided to go on an adventure through the forest.",
                          speed: Duration(milliseconds: 73)),
                      TypewriterAnimatedText(
                        'Benny walked along the path and saw colorful flowers. He said, "Flower" to himself as he admired it. Can you repeat after Benny, "Flower" to make it bloom?',
                        speed: Duration(milliseconds: 72),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 500)),
                      TypewriterAnimatedText(
                        'Benny saw a squirrel gathering nuts. He said, "Nuts" as he watched. Can you repeat after Benny, "Nuts" to help the squirrel collect them?',
                        speed: Duration(milliseconds: 75),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 500)),
                      TypewriterAnimatedText(
                        'Benny came across a stream and saw a fish swimming. He said, "Fish" as he watched. Can you repeat after Benny, "Fish" to help it swim upstream?',
                        speed: Duration(milliseconds: 71),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Benny saw a big, juicy apple hanging from a tree. He said, "Big Apple" as he approached it. Can you repeat after Benny, "Big Apple" to help him reach it?',
                        speed: Duration(milliseconds: 72),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 480)),
                      TypewriterAnimatedText(
                        'Benny saw a family of rabbits hopping around. He said, "Hop Together" as he tried to join in. Can you repeat after Benny, "Hop Together" to help him play with them?',
                        speed: Duration(milliseconds: 72),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Benny saw a butterfly flying in the sky. He said, "Pretty Butterfly" as he admired it. Can you repeat after Benny, "Pretty Butterfly" to help it land on his nose?',
                        speed: Duration(milliseconds: 74),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Benny saw a snake slithering through the jungle and said, "Slither, slither" as he followed it. Can you repeat after Benny, "Slither, slither" to help him track the snake?',
                        speed: Duration(milliseconds: 65),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Benny saw a group of animals in a clearing. He said, "Lets make friends with the animals" as he walked over. Can you repeat after Benny, "Lets make friends with the animals" to help him make new friends?',
                        speed: Duration(milliseconds: 68),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Benny saw a dark cave and heard strange noises. He said, "Im not scared, I can explore the cave" as he bravely walked in. Can you repeat after Benny, "Im not scared, I can explore the cave" to help him discover whats inside?',
                        speed: Duration(milliseconds: 73),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'As Benny finished his adventure, he realized that repeating words and sentences can be a fun and helpful way to communicate with friends and explore the world around him.',
                        speed: Duration(milliseconds: 71),
                      ),
                    ],
                    onFinished: () {
                      Timer(Duration(seconds: 2), () {
                        saveData();
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                congratsScreen(scoreStory1: score.toString())));
                      });
                    },
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    totalRepeatCount: 1,
                  ),
                ),
                width: double.infinity,
                height: 75,
              )),
          displayEar
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/ear.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isRight
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/check.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isWrong
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/wrong.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      )),
    );
  }
}

class story2 extends StatefulWidget {
  const story2({Key? key}) : super(key: key);

  @override
  State<story2> createState() => _story2State();
}

class _story2State extends State<story2> {
  //String scene = 'Once upon a time, there was a curious little bear named Benny. One day, Benny decided to go on an adventure through the forest.';
  SpeechToText _speech = SpeechToText();
  bool displayEar = false;
  bool _isListening = false;
  String _text = '';
  int score = 0;
  Timer? _timer;
  bool isRight = false;
  bool isWrong = false;
  String background = 'assets/images/story2images/scene1.gif';

  bool dialogue1 = true;
  bool dialogue2 = true;
  bool dialogue3 = true;
  bool dialogue4 = true;

  final player = AudioPlayer();

  @override
  void initState() {
    _speech = stt.SpeechToText();
    player.play(AssetSource("musics/story2first.mp3"));
    Timer(Duration(milliseconds: 12000), () {
      //displayEar = true;
      player.play(AssetSource("musics/story2second.mp3"));
      Timer(Duration(milliseconds: 11000), () {
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000), () {
          player.play(AssetSource("musics/story2third.mp3"));
          setState(() {
            background = 'assets/images/story2images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/
        });
      });
    });

    super.initState();
  }

  /*void scene1st(){
    player.play(AssetSource("musics/story1first.mp3"));
    Timer(Duration(milliseconds: 11000),(){
      //displayEar = true;
      player.play(AssetSource("musics/story1third.mp3"));
      Timer(Duration(milliseconds: 13000),(){
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000),(){
          player.play(AssetSource("musics/story1second.mp3"));
          setState(() {
            background = 'assets/images/story1images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          */ /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/ /*
        });
      });
    });
  }*/

  void scene2nd() {
    Timer(Duration(milliseconds: 11000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningNuts();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2fourth.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene3.gif';
          isRight = false;
          isWrong = false;
        });
        scene3rd();
        /*Timer(Duration(milliseconds: 1000),() {
          scene3rd();
        });*/
      });
    });
  }

  void scene3rd() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningFish();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2fifth.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene4.gif';
          isRight = false;
          isWrong = false;
        });
        scene4th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene4th();
        });*/
      });
    });
  }

  void scene4th() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningBigApple();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2sixth.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene5.gif';
          isRight = false;
          isWrong = false;
        });
        scene5th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene5th();
        });*/
      });
    });
  }

  void scene5th() {
    Timer(Duration(milliseconds: 14000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningHopTogether();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2seventh.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene6.gif';
          isRight = false;
          isWrong = false;
        });
        scene6th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene6th();
        });*/
      });
    });
  }

  void scene6th() {
    Timer(Duration(milliseconds: 13000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningPrettyButterfly();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2eight.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene7.gif';
          isRight = false;
          isWrong = false;
        });
        scene7th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene7th();
        });*/
      });
    });
  }

  void scene7th() {
    Timer(Duration(milliseconds: 14000), () {
      setState(() {
        displayEar = true;
        // scene = '';
      });
      _startListeningSlither();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2ninth.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene8.gif';
          isRight = false;
          isWrong = false;
        });
        scene8th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene8th();
        });*/
      });
    });
  }

  void scene8th() {
    Timer(Duration(milliseconds: 14000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningLetsMakeFriends();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story2tenth.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
        scene9th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene9th();
        });*/
      });
    });
  }

  void scene9th() {
    Timer(Duration(milliseconds: 17000), () {
      setState(() {
        displayEar = true;
        //scene = '';
      });
      _startListeningImNotScared();
      Timer(Duration(milliseconds: 13000), () {
        player.play(AssetSource("musics/story2eleventh.mp3"));
        setState(() {
          background = 'assets/images/story2images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
      });
    });
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
        String dont = "Don't worry I will get you out of there";
        print(splitText);
        if (_text == dont) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String letsclimb = "Let's climb the mountain";
        print(splitText);
        if (_text == letsclimb) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String penguin = "follow the penguin";
        print(splitText);
        if (_text == penguin) {
          score = score + 15;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String flybirds = "fly birds";
        print(splitText);
        if (_text == flybirds) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String slidetogether = "slide together";
        print(splitText);
        if (_text == slidetogether) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String bigsnowball = "big snowball";
        print(splitText);
        if (_text == bigsnowball) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }
        //if(splitText.any((element) => bigapple.contains(element))){}
        else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String seal = "seal";
        print(splitText);
        if (splitText.any((element) => seal.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String snowman = "snowman";
        print(splitText);
        if (splitText.any((element) => snowman.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String snowflake = "snowflake";
        print(splitText);
        if (splitText.any((element) => snowflake.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();
    _speech.stop();

    super.dispose();
  }

  void saveData() async {
    print('test1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('sda' + score.toString());
    prefs.setInt("scoreKeyStory2", score);
    print('test2');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();

        return true;
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage(background),
              fit: BoxFit.cover, // set the image scaling mode
            ),
          ),
          Positioned(
            left: 30,
            bottom: 20,
            child: Image.asset('assets/images/story2char.png',
                fit: BoxFit.cover, height: 190),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(color: Colors.grey),
                ),
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                ),
              )),
          /*Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(scene,style: TextStyle(color: Colors.grey,fontSize: 16),),

                  width: double.infinity,
                  height: 75,

                )
            ),*/
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.yellow, fontSize: 16),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("_",
                          speed: Duration(milliseconds: 10)),
                      TypewriterAnimatedText(
                          "Once upon a time, there was a little penguin named Pengu who loved to play in the snow. One day, Pengu decided to go on a winter adventure.",
                          speed: Duration(milliseconds: 74)),
                      TypewriterAnimatedText(
                        'Pengu saw a snowflake and said, "Snowflake" as it landed on his beak. Can you repeat after Pengu, "Snowflake" to make it snow?',
                        speed: Duration(milliseconds: 74),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 480)),
                      TypewriterAnimatedText(
                        'Pengu saw a snowman and said, "Snowman" as he hugged it. Can you repeat after Pengu, "Snowman" to give it a warm hug too?',
                        speed: Duration(milliseconds: 77),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 490)),
                      TypewriterAnimatedText(
                        'Pengu came across a pond and saw a seal swimming. He said, "Seal" as he watched it. Can you repeat after Pengu, "Seal" to help it swim?',
                        speed: Duration(milliseconds: 76),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 500)),
                      TypewriterAnimatedText(
                        'Pengu saw a snowball and said, "Big Snowball" as he rolled it. Can you repeat after Pengu, "Big Snowball" to help him make it even bigger?',
                        speed: Duration(milliseconds: 74),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 510)),
                      TypewriterAnimatedText(
                        'Pengu saw a group of penguins sliding down a hill. He said, "Slide Together" as he joined in. Can you repeat after Pengu, "Slide Together" to help him have fun with his new friends?',
                        speed: Duration(milliseconds: 72),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 488)),
                      TypewriterAnimatedText(
                        'Pengu saw a group of birds flying in the sky. He said, "Fly Birds" as he watched it. Can you repeat after Pengu, "Fly Birds" to help them soar higher?',
                        speed: Duration(milliseconds: 76),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 470)),
                      TypewriterAnimatedText(
                        'Pengu saw a penguin swimming in the ocean and said, "Follow the Penguin" as he waddled after it. Can you repeat after Pengu, "Follow the Penguin" to help him find a new friend?',
                        speed: Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 510)),
                      TypewriterAnimatedText(
                        'Pengu saw a mountain in the distance and said, "Lets climb the mountain" as he set out on a journey. Can you repeat after Pengu, "Lets climb the mountain" to help him reach the top?',
                        speed: Duration(milliseconds: 66),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 515)),
                      TypewriterAnimatedText(
                        'Pippy the penguin was stuck in deep snow and called out for help. Pengu rushed over and said, "Dont worry, I will get you out of there!" Can you repeat after Pengu to reassure Pippy and let her know that her friends are there to help?',
                        speed: Duration(milliseconds: 67),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 510)),
                      TypewriterAnimatedText(
                        'As Pengu finished her adventure, she realized that repeating words and sentences can be a fun and helpful way to communicate with friends and explore the winter wonderland.',
                        speed: Duration(milliseconds: 65),
                      ),
                    ],
                    onFinished: () {
                      Timer(Duration(seconds: 2), () {
                        saveData();
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                congratsScreen(scoreStory1: score.toString())));
                      });
                    },
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    totalRepeatCount: 1,
                  ),
                ),
                width: double.infinity,
                height: 75,
              )),
          displayEar
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/ear.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isRight
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/check.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isWrong
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/wrong.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      )),
    );
  }
}

class story3 extends StatefulWidget {
  const story3({Key? key}) : super(key: key);

  @override
  State<story3> createState() => _story3State();
}

class _story3State extends State<story3> {
  //String scene = 'Once upon a time, there was a curious little bear named Benny. One day, Benny decided to go on an adventure through the forest.';
  SpeechToText _speech = SpeechToText();
  bool displayEar = false;
  bool _isListening = false;
  String _text = '';
  int score = 0;
  Timer? _timer;
  bool isRight = false;
  bool isWrong = false;
  String background = 'assets/images/story3images/scene1.gif';

  bool dialogue1 = true;
  bool dialogue2 = true;
  bool dialogue3 = true;
  bool dialogue4 = true;

  final player = AudioPlayer();

  @override
  void initState() {
    _speech = stt.SpeechToText();
    player.play(AssetSource("musics/story3first.mp3"));
    Timer(Duration(milliseconds: 11000), () {
      //displayEar = true;
      player.play(AssetSource("musics/story3second.mp3"));
      Timer(Duration(milliseconds: 14000), () {
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000), () {
          player.play(AssetSource("musics/story3third.mp3"));
          setState(() {
            background = 'assets/images/story3images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/
        });
      });
    });

    super.initState();
  }

  /*void scene1st(){
    player.play(AssetSource("musics/story1first.mp3"));
    Timer(Duration(milliseconds: 11000),(){
      //displayEar = true;
      player.play(AssetSource("musics/story1third.mp3"));
      Timer(Duration(milliseconds: 13000),(){
        setState(() {
          displayEar = true;
          //scene = '';
        });
        _startListeningFlower();
        Timer(Duration(milliseconds: 12000),(){
          player.play(AssetSource("musics/story1second.mp3"));
          setState(() {
            background = 'assets/images/story1images/scene2.gif';
            isRight = false;
            isWrong = false;
          });
          scene2nd();
          */ /*Timer(Duration(milliseconds: 1000),(){
            scene2nd();
          });*/ /*
        });
      });
    });
  }*/

  void scene2nd() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningNuts();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3fourth.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene3.gif';
          isRight = false;
          isWrong = false;
        });
        scene3rd();
        /*Timer(Duration(milliseconds: 1000),() {
          scene3rd();
        });*/
      });
    });
  }

  void scene3rd() {
    Timer(Duration(milliseconds: 12000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningFish();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3fifth.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene4.gif';
          isRight = false;
          isWrong = false;
        });
        scene4th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene4th();
        });*/
      });
    });
  }

  void scene4th() {
    Timer(Duration(milliseconds: 15000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningBigApple();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3sixth.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene5.gif';
          isRight = false;
          isWrong = false;
        });
        scene5th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene5th();
        });*/
      });
    });
  }

  void scene5th() {
    Timer(Duration(milliseconds: 14000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningHopTogether();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3seventh.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene6.gif';
          isRight = false;
          isWrong = false;
        });
        scene6th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene6th();
        });*/
      });
    });
  }

  void scene6th() {
    Timer(Duration(milliseconds: 17000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningPrettyButterfly();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3eight.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene7.gif';
          isRight = false;
          isWrong = false;
        });
        scene7th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene7th();
        });*/
      });
    });
  }

  void scene7th() {
    Timer(Duration(milliseconds: 16000), () {
      setState(() {
        displayEar = true;
        // scene = '';
      });
      _startListeningSlither();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3ninth.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene8.gif';
          isRight = false;
          isWrong = false;
        });
        scene8th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene8th();
        });*/
      });
    });
  }

  void scene8th() {
    Timer(Duration(milliseconds: 15000), () {
      setState(() {
        displayEar = true;
      });
      _startListeningLetsMakeFriends();
      Timer(Duration(milliseconds: 12000), () {
        player.play(AssetSource("musics/story3tenth.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
        scene9th();
        /*Timer(Duration(milliseconds: 1000),() {
          scene9th();
        });*/
      });
    });
  }

  void scene9th() {
    Timer(Duration(milliseconds: 15000), () {
      setState(() {
        displayEar = true;
        //scene = '';
      });
      _startListeningImNotScared();
      Timer(Duration(milliseconds: 14000), () {
        player.play(AssetSource("musics/story3eleventh.mp3"));
        setState(() {
          background = 'assets/images/story3images/scene9.gif';
          isRight = false;
          isWrong = false;
        });
      });
    });
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
        String dont = "i love jumping in puddles";
        print(splitText);
        if (_text == dont) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String letsclimb = "let's have a frog party";
        print(splitText);
        if (_text == letsclimb) {
          score = score + 20;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String penguin = "i will get you mouse";
        print(splitText);
        if (_text == penguin) {
          score = score + 15;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String flybirds = "need help";
        print(splitText);
        if (_text == flybirds) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String slidetogether = "fluffy sheep";
        print(splitText);
        if (_text == slidetogether) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String bigsnowball = "pumpkin patch";
        print(splitText);
        if (_text == bigsnowball) {
          score = score + 10;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }
        //if(splitText.any((element) => bigapple.contains(element))){}
        else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String seal = "duck";
        print(splitText);
        if (splitText.any((element) => seal.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String snowman = "cow";
        print(splitText);
        if (splitText.any((element) => snowman.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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
        String snowflake = "egg";
        print(splitText);
        if (splitText.any((element) => snowflake.contains(element)) &&
            _text.isNotEmpty) {
          score = score + 5;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        } else if (_text.isEmpty) {
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        } else {
          score = score + 0;
          setState(() {
            displayEar = false;
            isWrong = true;
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

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();
    _speech.stop();

    super.dispose();
  }

  void saveData() async {
    print('test1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('sda' + score.toString());
    prefs.setInt("scoreKeyStory3", score);
    print('test2');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();

        return true;
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage(background),
              fit: BoxFit.cover, // set the image scaling mode
            ),
          ),
          Positioned(
            left: 30,
            bottom: 20,
            child: Image.asset('assets/images/story3char.png',
                fit: BoxFit.cover, height: 190),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(color: Colors.grey),
                ),
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                ),
              )),
          /*Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(scene,style: TextStyle(color: Colors.grey,fontSize: 16),),

                  width: double.infinity,
                  height: 75,

                )
            ),*/
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.yellow, fontSize: 16),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      //TypewriterAnimatedText("_",speed: Duration(milliseconds: 3)),
                      TypewriterAnimatedText(
                          "Once upon a time, there was a curious little piglet named Poppy. One day, Poppy decided to explore the farm where she lived.",
                          speed: Duration(milliseconds: 75)),
                      TypewriterAnimatedText(
                        'Poppy trotted over to the chicken coop and saw a hen laying an egg. She said, "Egg" to herself as she watched. Can you repeat after Poppy, "Egg" to help the hen lay its egg?',
                        speed: Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 530)),
                      TypewriterAnimatedText(
                        'Poppy spotted a cow in the field, munching on some hay. She said, "Cow" as she walked by. Can you repeat after Poppy, "Cow" to say hello to the cow?',
                        speed: Duration(milliseconds: 74),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 490)),
                      TypewriterAnimatedText(
                        'Poppy heard a duck quacking by the pond. She said, "Duck" as she looked over. Can you repeat after Poppy, "Duck" to call out to the duck?',
                        speed: Duration(milliseconds: 75),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 500)),
                      TypewriterAnimatedText(
                        'Poppy came across a pile of pumpkins in the garden. She said, "Pumpkin Patch" as she sniffed around. Can you repeat after Poppy, "Pumpkin Patch" to help her find her way through the patch?',
                        speed: Duration(milliseconds: 70),
                      ),

                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 510)),
                      TypewriterAnimatedText(
                        'Poppy saw a flock of sheep grazing in a meadow. She said, "Fluffy Sheep" as she watched them. Can you repeat after Poppy, "Fluffy Sheep" to call out to the sheep?',
                        speed: Duration(milliseconds: 75),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 490)),

                      TypewriterAnimatedText(
                        'Poppy notice a cat stuck in a fence. Poppy approach the cat and say, "Need help?" The cat meows in response. Can you repeat after Poppy, "Need help?" to signal to her friend that the cat needs assistance?',
                        speed: Duration(milliseconds: 73),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 510)),
                      TypewriterAnimatedText(
                        'Poppy wandered over to the barn and saw a mouse scurrying along the wall. She said, "I will get you mouse" as she followed it. Can you repeat after Poppy, "I will get you mouse" to help her catch the mouse?',
                        speed: Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 530)),
                      TypewriterAnimatedText(
                        'Poppy saw a group of frogs in a puddle. She said, "Lets have a frog party" as she walked over. Can you repeat after Poppy, "Lets have a frog party" to help her organize a fun gathering?',
                        speed: Duration(milliseconds: 70),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 515)),
                      TypewriterAnimatedText(
                        'Poppy saw a big, muddy puddle in the yard. She said, "I love jumping in puddles" as she ran towards it. Can you repeat after Poppy, "I love jumping in puddles" to help her make a big splash?',
                        speed: Duration(milliseconds: 68),
                      ),
                      TypewriterAnimatedText('. . . . . . . ',
                          speed: Duration(milliseconds: 530)),
                      TypewriterAnimatedText(
                        'As Poppy finished her adventure, she realized that repeating words and sentences can be a fun and helpful way to communicate with her farm animal friends and explore the world around her.',
                        speed: Duration(milliseconds: 64),
                      ),
                    ],
                    onFinished: () {
                      Timer(Duration(seconds: 2), () {
                        saveData();
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                congratsScreen(scoreStory1: score.toString())));
                      });
                    },
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    totalRepeatCount: 1,
                  ),
                ),
                width: double.infinity,
                height: 75,
              )),
          displayEar
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/ear.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isRight
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/check.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          isWrong
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(.6)),
                        child: Center(
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/wrong.gif')),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      )),
    );
  }
}

class congratsScreen extends StatefulWidget {
  //const congratsScreen({Key? key}) : super(key: key);

  congratsScreen({required this.scoreStory1});
  String scoreStory1;

  @override
  State<congratsScreen> createState() => _congratsScreenState();
}

class _congratsScreenState extends State<congratsScreen> {
  double _paddingPlay = 6.0;
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;

  @override
  void initState() {
    if (int.parse(widget.scoreStory1) >= 33) {
      setState(() {
        star1 = true;
      });
      if (int.parse(widget.scoreStory1) <= 66 &&
          int.parse(widget.scoreStory1) >= 34) {
        setState(() {
          star2 = true;
        });
        if (int.parse(widget.scoreStory1) >= 67) {
          setState(() {
            star3 = true;
          });
        }
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/scorescreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        star1
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/star.png'))
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/nostar.png')),
                        star2
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/star.png'))
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/nostar.png')),
                        star3
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/star.png'))
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 40,
                                child: Image.asset('assets/images/nostar.png')),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Congratulations!',
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        'Your Score: ${widget.scoreStory1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTapDown: (_) => setState(() {
                          _paddingPlay = 0.0;
                        }),
                        onTapUp: (_) => setState(() {
                          _paddingPlay = 6.0;
                        }),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.only(bottom: _paddingPlay),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            child: Text(
                              'HOME',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
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
