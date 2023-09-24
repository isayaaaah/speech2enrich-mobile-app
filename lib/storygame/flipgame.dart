import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech2enrich/storygame/instruct.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../global.dart';

class memorymenu extends StatefulWidget {
  const memorymenu({Key? key}) : super(key: key);

  @override
  State<memorymenu> createState() => _memorymenuState();
}

class _memorymenuState extends State<memorymenu> {


  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    EdgeInsets _padding = MediaQuery.of(context).padding;



    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/matchmemorymenu.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      bgAudio1.pause();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FlipCardMemoryGameEasy()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 50, right: 50, top: 75, bottom: 5),
                      height: 65,
                      width: phoneWidth - 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF69affe),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'EASY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bgAudio1.pause();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FlipCardMemoryGameMedium()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      height: 65,
                      width: phoneWidth - 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFbd8aff),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'MEDIUM',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bgAudio1.pause();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FlipCardMemoryGameHard()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      height: 65,
                      width: phoneWidth - 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFfb6f5a),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'DIFFICULT',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SafeArea(
            child: Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => instructmemory()));
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

List<Map<String, dynamic>> labelper = [
  {
    "title": "A1",
  },
  {"title": "B1"},
  {"title": "C1"},
  {"title": "D1"},
  {"title": "E1"},
  {"title": "A2"},
  {"title": "B2"},
  {"title": "C2"},
  {"title": "D2"},
  {"title": "E2"},
];

class FlipCardMemoryGameEasy extends StatefulWidget {
  @override
  _FlipCardMemoryGameEasyState createState() => _FlipCardMemoryGameEasyState();
}

class _FlipCardMemoryGameEasyState extends State<FlipCardMemoryGameEasy> {
  List<String> _items = [
    "assets/images/flipgame/animal1.png",
    "assets/images/flipgame/animal2.png",
    "assets/images/flipgame/animal3.png",
    "assets/images/flipgame/animal4.png",
    "assets/images/flipgame/animal5.png",
  ];

  List<String> _duplicates = [];
  List<String> _shuffledItems = [];
  List<bool> _flipped = [];
  int _scoreEasyMemory = 0;
  int _tries = 0;
  int _previousIndex = -1;
  bool _isListening = false;
  String _transcription = '';
  Timer? _timer;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _generateCards();
    _speech = stt.SpeechToText();
    _loopListen();
    print(_isListening);
  }

  int _counter = 0;
  bool _shouldStop = false;

  void _loopListen() {
    if (!_shouldStop && _counter < 100) {
      Timer(Duration(seconds: 3), () {
        _listen();
        _counter++;
        _loopListen();
        print(_counter);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();
    _shouldStop = true;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _generateCards() {
    _duplicates = [];
    _items.forEach((item) {
      _duplicates.add(item);
      _duplicates.add(item);
    });
    _shuffledItems = _duplicates.toList()..shuffle();
    _flipped = List<bool>.filled(_duplicates.length, false);
    _scoreEasyMemory = 0;
    _tries = 0;
    _previousIndex = -1;
  }

  void _resetCards() {
    setState(() {
      _generateCards();
    });
  }

  void _flipCard(int index) {
    if (_flipped[index]) return;

    setState(() {
      _flipped[index] = true;

      if (_previousIndex == -1) {
        _previousIndex = index;
      } else {
        _tries++;

        if (_shuffledItems[_previousIndex] == _shuffledItems[index]) {
          _scoreEasyMemory++;
          _previousIndex = -1;
        } else {
          Future.delayed(Duration(milliseconds: 1000), () {
            setState(() {
              _flipped[_previousIndex] = false;
              _flipped[index] = false;
              _previousIndex = -1;
            });
          });
        }
      }
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
            _flipTileFromVoice();
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void _flipTileFromVoice() {
    if (_transcription.isNotEmpty) {
      //int? tileNumber = int.tryParse(_transcription);
      String tileString = _transcription;
      if (tileString != null &&
          tileString == 'a1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 1;
        if (tileString != null &&
            tileString == 'a1' &&
            tileNumber <= _duplicates.length) {
          int index = 0;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'a2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 6;
        if (tileString != null &&
            tileString == 'a2' &&
            tileNumber <= _duplicates.length) {
          int index = 5;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 2;
        if (tileString != null &&
            tileString == 'b1' &&
            tileNumber <= _duplicates.length) {
          int index = 1;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 7;
        if (tileString != null &&
            tileString == 'b2' &&
            tileNumber <= _duplicates.length) {
          int index = 6;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 3;
        if (tileString != null &&
            tileString == 'c1' &&
            tileNumber <= _duplicates.length) {
          int index = 2;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 8;
        if (tileString != null &&
            tileString == 'c2' &&
            tileNumber <= _duplicates.length) {
          int index = 7;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'd1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 4;
        if (tileString != null &&
            tileString == 'd1' &&
            tileNumber <= _duplicates.length) {
          int index = 3;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'd2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 9;
        if (tileString != null &&
            tileString == 'd2' &&
            tileNumber <= _duplicates.length) {
          int index = 8;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'e1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 5;
        if (tileString != null &&
            tileString == 'e1' &&
            tileNumber <= _duplicates.length) {
          int index = 4;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'e2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 10;
        if (tileString != null &&
            tileString == 'e2' &&
            tileNumber <= _duplicates.length) {
          int index = 9;
          _flipCard(index);
        }
      }

      setState(() {
        _transcription = '';
      });
    }
  }

  void _scoring() async {
    print('test1');
    double _scoreEasy = (100 * (1 - (_tries / 100))) + _scoreEasyMemory;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("scoreEasyMemory", _scoreEasy.toInt());
    print('Score Easy Memory $_scoreEasy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/matchmemoryscreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: $_scoreEasyMemory   |   Tries: $_tries   ',
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          _resetCards();
                        },
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('assets/images/reset.png')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _duplicates.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _flipCard(index);
                            if (_scoreEasyMemory == 5) {
                              _scoring();
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => congratsScreen(scoreStory1: _scoreEasyMemory.toString(),tries: _tries.toString(),)));
                            }
                          },
                          child: _flipped[index]
                              ? Container(
                            decoration: BoxDecoration(
                              color: Color(0xffa5d1ff),
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(_shuffledItems![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(),
                          )
                              : Container(
                            color: Colors.grey,
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${labelper.elementAt(index)['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 68, 28, 4)
                                            .withOpacity(1),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),

                  /*
                  ElevatedButton(
                      onPressed: (){
                        _listen();
                        print(_transcription);
                      },
                      child: Text('Voice'))*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlipCardMemoryGameMedium extends StatefulWidget {
  @override
  _FlipCardMemoryGameMediumState createState() =>
      _FlipCardMemoryGameMediumState();
}

class _FlipCardMemoryGameMediumState extends State<FlipCardMemoryGameMedium> {
  List<Map<String, dynamic>> labelper = [
    {
      "title": "A1",
    },
    {"title": "B1"},
    {"title": "C1"},
    {"title": "D1"},
    {"title": "E1"},
    {"title": "F1"},
    {"title": "G1"},
    {"title": "A2"},
    {"title": "B2"},
    {"title": "C2"},
    {"title": "D2"},
    {"title": "E2"},
    {"title": "F2"},
    {"title": "G2"},
  ];
  List<String> _items = [
    "assets/images/flipgame/animal1.png",
    "assets/images/flipgame/animal2.png",
    "assets/images/flipgame/animal3.png",
    "assets/images/flipgame/animal4.png",
    "assets/images/flipgame/animal5.png",
    "assets/images/flipgame/animal6.png",
    "assets/images/flipgame/animal7.png",
  ];
  List<String> _duplicates = [];
  List<String> _shuffledItems = [];
  List<bool> _flipped = [];
  int _score = 0;
  int _tries = 0;
  int _previousIndex = -1;
  bool _isListening = false;
  String _transcription = '';
  Timer? _timer;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _generateCards();
    _speech = stt.SpeechToText();
    _loopListen();
    print(_isListening);
  }

  int _counter = 0;
  bool _shouldStop = false;

  void _loopListen() {
    if (!_shouldStop && _counter < 100) {
      Timer(Duration(seconds: 3), () {
        _listen();
        _counter++;
        _loopListen();
        print(_counter);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();
    _shouldStop = true;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _generateCards() {
    _duplicates = [];
    _items.forEach((item) {
      _duplicates.add(item);
      _duplicates.add(item);
    });
    _shuffledItems = _duplicates.toList()..shuffle();
    _flipped = List<bool>.filled(_duplicates.length, false);
    _score = 0;
    _tries = 0;
    _previousIndex = -1;
  }

  void _resetCards() {
    setState(() {
      _generateCards();
    });
  }

  void _flipCard(int index) {
    if (_flipped[index]) return;

    setState(() {
      _flipped[index] = true;

      if (_previousIndex == -1) {
        _previousIndex = index;
      } else {
        _tries++;

        if (_shuffledItems[_previousIndex] == _shuffledItems[index]) {
          _score++;
          _previousIndex = -1;
        } else {
          Future.delayed(Duration(milliseconds: 1000), () {
            setState(() {
              _flipped[_previousIndex] = false;
              _flipped[index] = false;
              _previousIndex = -1;
            });
          });
        }
      }
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
            _flipTileFromVoice();
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void _flipTileFromVoice() {
    if (_transcription.isNotEmpty) {
      //int? tileNumber = int.tryParse(_transcription);
      String tileString = _transcription;
      if (tileString != null &&
          tileString == 'a1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 1;
        if (tileString != null &&
            tileString == 'a1' &&
            tileNumber <= _duplicates.length) {
          int index = 0;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'a2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 8;
        if (tileString != null &&
            tileString == 'a2' &&
            tileNumber <= _duplicates.length) {
          int index = 7;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 2;
        if (tileString != null &&
            tileString == 'b1' &&
            tileNumber <= _duplicates.length) {
          int index = 1;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 9;
        if (tileString != null &&
            tileString == 'b2' &&
            tileNumber <= _duplicates.length) {
          int index = 8;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 3;
        if (tileString != null &&
            tileString == 'c1' &&
            tileNumber <= _duplicates.length) {
          int index = 2;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 10;
        if (tileString != null &&
            tileString == 'c2' &&
            tileNumber <= _duplicates.length) {
          int index = 9;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'd1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 4;
        if (tileString != null &&
            tileString == 'd1' &&
            tileNumber <= _duplicates.length) {
          int index = 3;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'd2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 11;
        if (tileString != null &&
            tileString == 'd2' &&
            tileNumber <= _duplicates.length) {
          int index = 10;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'e1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 5;
        if (tileString != null &&
            tileString == 'e1' &&
            tileNumber <= _duplicates.length) {
          int index = 4;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'e2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 12;
        if (tileString != null &&
            tileString == 'e2' &&
            tileNumber <= _duplicates.length) {
          int index = 11;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'f1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 6;
        if (tileString != null &&
            tileString == 'f1' &&
            tileNumber <= _duplicates.length) {
          int index = 5;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'f2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 13;
        if (tileString != null &&
            tileString == 'f2' &&
            tileNumber <= _duplicates.length) {
          int index = 12;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'g1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 7;
        if (tileString != null &&
            tileString == 'g1' &&
            tileNumber <= _duplicates.length) {
          int index = 6;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'g2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 14;
        if (tileString != null &&
            tileString == 'g2' &&
            tileNumber <= _duplicates.length) {
          int index = 13;
          _flipCard(index);
        }
      }

      setState(() {
        _transcription = '';
      });
    }
  }

  void _scoring() async {
    print('test1');
    double _scoreMed = (100 * (1 - (_tries / 100))) + _score;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("scoreMediumMemory", _scoreMed.toInt());
    print('Score Easy Memory $_scoreMed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/matchmemoryscreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: $_score   |   Tries: $_tries   ',
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          _resetCards();
                        },
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('assets/images/reset.png')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _duplicates.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _flipCard(index);
                            if (_score == 7) {
                              _scoring();
                            }
                          },
                          child: _flipped[index]
                              ? Container(
                            decoration: BoxDecoration(
                              color: Color(0xffa5d1ff),
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(_shuffledItems![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(),
                          )
                              : Container(
                            color: Colors.grey,
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${labelper.elementAt(index)['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 68, 28, 4)
                                            .withOpacity(1),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),

                  /*
                  ElevatedButton(
                      onPressed: (){
                        _listen();
                        print(_transcription);
                      },
                      child: Text('Voice'))*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlipCardMemoryGameHard extends StatefulWidget {
  @override
  _FlipCardMemoryGameHardState createState() => _FlipCardMemoryGameHardState();
}

class _FlipCardMemoryGameHardState extends State<FlipCardMemoryGameHard> {
  List<Map<String, dynamic>> labelper = [
    {
      "title": "A1",
    },
    {"title": "B1"},
    {"title": "C1"},
    {"title": "D1"},
    {"title": "E1"},
    {"title": "F1"},
    {"title": "G1"},
    {"title": "H1"},
    {"title": "A2"},
    {"title": "B2"},
    {"title": "C2"},
    {"title": "D2"},
    {"title": "E2"},
    {"title": "F2"},
    {"title": "G2"},
    {"title": "H2"},
    {"title": "A3"},
    {"title": "B3"},
    {"title": "C3"},
    {"title": "D3"},
    {"title": "E3"},
    {"title": "F3"},
    {"title": "G3"},
    {"title": "H3"}
  ];
  List<String> _items = [
    "assets/images/flipgame/animal1.png",
    "assets/images/flipgame/animal2.png",
    "assets/images/flipgame/animal3.png",
    "assets/images/flipgame/animal4.png",
    "assets/images/flipgame/animal5.png",
    "assets/images/flipgame/animal6.png",
    "assets/images/flipgame/animal7.png",
    "assets/images/flipgame/animal8.png",
    "assets/images/flipgame/obj5.png",
    "assets/images/flipgame/obj6.png",
    "assets/images/flipgame/obj7.png",
    "assets/images/flipgame/obj8.png",
  ];
  List<String> _duplicates = [];
  List<String> _shuffledItems = [];
  List<bool> _flipped = [];
  int _score = 0;
  int _tries = 0;
  int _previousIndex = -1;
  bool _isListening = false;
  String _transcription = '';
  Timer? _timer;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _generateCards();
    _speech = stt.SpeechToText();
    _loopListen();
    print(_isListening);
  }

  int _counter = 0;
  bool _shouldStop = false;

  void _loopListen() {
    if (!_shouldStop && _counter < 100) {
      Timer(Duration(seconds: 3), () {
        _listen();
        _counter++;
        _loopListen();
        print(_counter);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();
    _shouldStop = true;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _generateCards() {
    _duplicates = [];
    _items.forEach((item) {
      _duplicates.add(item);
      _duplicates.add(item);
    });
    _shuffledItems = _duplicates.toList()..shuffle();
    _flipped = List<bool>.filled(_duplicates.length, false);
    _score = 0;
    _tries = 0;
    _previousIndex = -1;
  }

  void _resetCards() {
    setState(() {
      _generateCards();
    });
  }

  void _flipCard(int index) {
    if (_flipped[index]) return;

    setState(() {
      _flipped[index] = true;

      if (_previousIndex == -1) {
        _previousIndex = index;
      } else {
        _tries++;

        if (_shuffledItems[_previousIndex] == _shuffledItems[index]) {
          _score++;
          _previousIndex = -1;
        } else {
          Future.delayed(Duration(milliseconds: 1000), () {
            setState(() {
              _flipped[_previousIndex] = false;
              _flipped[index] = false;
              _previousIndex = -1;
            });
          });
        }
      }
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
            _flipTileFromVoice();
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void _flipTileFromVoice() {
    if (_transcription.isNotEmpty) {
      //int? tileNumber = int.tryParse(_transcription);
      String tileString = _transcription;
      if (tileString != null &&
          tileString == 'a1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 1;
        if (tileString != null &&
            tileString == 'a1' &&
            tileNumber <= _duplicates.length) {
          int index = 0;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'a2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 4;
        if (tileString != null &&
            tileString == 'a2' &&
            tileNumber <= _duplicates.length) {
          int index = 3;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'a3' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 7;
        if (tileString != null &&
            tileString == 'a3' &&
            tileNumber <= _duplicates.length) {
          int index = 6;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'a4' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 10;
        if (tileString != null &&
            tileString == 'a4' &&
            tileNumber <= _duplicates.length) {
          int index = 9;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 2;
        if (tileString != null &&
            tileString == 'b1' &&
            tileNumber <= _duplicates.length) {
          int index = 1;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 5;
        if (tileString != null &&
            tileString == 'b2' &&
            tileNumber <= _duplicates.length) {
          int index = 4;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b3' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 8;
        if (tileString != null &&
            tileString == 'b3' &&
            tileNumber <= _duplicates.length) {
          int index = 7;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'b4' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 11;
        if (tileString != null &&
            tileString == 'b4' &&
            tileNumber <= _duplicates.length) {
          int index = 10;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c1' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 3;
        if (tileString != null &&
            tileString == 'c1' &&
            tileNumber <= _duplicates.length) {
          int index = 2;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c2' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 6;
        if (tileString != null &&
            tileString == 'c2' &&
            tileNumber <= _duplicates.length) {
          int index = 5;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c3' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 9;
        if (tileString != null &&
            tileString == 'c3' &&
            tileNumber <= _duplicates.length) {
          int index = 8;
          _flipCard(index);
        }
      } else if (tileString != null &&
          tileString == 'c4' /*&& tileNumber <= _duplicates.length*/) {
        int tileNumber = 12;
        if (tileString != null &&
            tileString == 'c4' &&
            tileNumber <= _duplicates.length) {
          int index = 11;
          _flipCard(index);
        }
      }

      setState(() {
        _transcription = '';
      });
    }
  }

  void _scoring() async {
    print('test1');
    double _scoreHard = (100 * (1 - (_tries / 100))) + _score;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("scoreHardMemory", _scoreHard.toInt());
    print('Score Hard Memory $_scoreHard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/matchmemoryscreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: $_score   |   Tries: $_tries   ',
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          _resetCards();
                        },
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('assets/images/reset.png')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _duplicates.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _flipCard(index);
                            if (_score == 12) {
                              _scoring();
                            }
                          },
                          child: _flipped[index]
                              ? Container(
                            decoration: BoxDecoration(
                              color: Color(0xffa5d1ff),
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(_shuffledItems![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(),
                          )
                              : Container(
                            color: Colors.grey,
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${labelper.elementAt(index)['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 68, 28, 4)
                                            .withOpacity(1),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),

                  /*
                  ElevatedButton(
                      onPressed: (){
                        _listen();
                        print(_transcription);
                      },
                      child: Text('Voice'))*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class congratsScreen extends StatefulWidget {
  //const congratsScreen({Key? key}) : super(key: key);

  congratsScreen({required this.scoreStory1, required this.tries});
  String scoreStory1;
  String tries;

  @override
  State<congratsScreen> createState() => _congratsScreenState();
}

class _congratsScreenState extends State<congratsScreen> {
  double _paddingPlay = 6.0;
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  double? scoreFinal;

  @override
  void initState() {
    scoreFinal = (100 * (1 - (int.parse(widget.tries) / 100))) + int.parse(widget.scoreStory1);
    if (scoreFinal! >= 75) {
      setState(() {
        star1 = true;
      });
      if (scoreFinal! >= 85) {
        setState(() {
          star2 = true;
        });
        if (scoreFinal! >= 95) {
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
                        'Your Score: ${(100 * (1 - (int.parse(widget.tries) / 100))) + int.parse(widget.scoreStory1)}',
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => memorymenu()));
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
