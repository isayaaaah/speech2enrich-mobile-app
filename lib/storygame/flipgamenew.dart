import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
          )
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
    "assets/images/animal1.png",
    "assets/images/animal2.png",
    "assets/images/animal3.png",
    "assets/images/animal4.png",
    "assets/images/animal5.png"
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
    "assets/images/animal1.png",
    "assets/images/animal2.png",
    "assets/images/animal3.png",
    "assets/images/animal4.png",
    "assets/images/animal5.png",
    "assets/images/animal6.png",
    "assets/images/animal7.png",
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
      "title": "1",
    },
    {"title": "2"},
    {"title": "3"},
    {"title": "4"},
    {"title": "5"},
    {"title": "6"},
    {"title": "7"},
    {"title": "8"},
    {"title": "9"},
    {"title": "10"},
    {"title": "11"},
    {"title": "12"},
    {"title": "13"},
    {"title": "14"},
    {"title": "15"},
    {"title": "16"},
    {"title": "17"},
    {"title": "18"},
    {"title": "19"},
    {"title": "20"},
    {"title": "21"},
    {"title": "22"},
    {"title": "23"},
    {"title": "24"}
  ];
  List<String> _items = [
    "assets/images/animal1.png",
    "assets/images/animal2.png",
    "assets/images/animal3.png",
    "assets/images/animal4.png",
    "assets/images/animal5.png",
    "assets/images/animal6.png",
    "assets/images/animal7.png",
    "assets/images/animal8.png",
    "assets/images/obj5.png",
    "assets/images/obj6.png",
    "assets/images/obj7.png",
    "assets/images/obj8.png",
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
