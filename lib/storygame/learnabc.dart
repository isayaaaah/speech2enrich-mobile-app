import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

import '../global.dart';

class learnabc extends StatefulWidget {
  const learnabc({Key? key}) : super(key: key);

  @override
  State<learnabc> createState() => _learnabcState();
}

class _learnabcState extends State<learnabc> {

  double _paddingPlay = 6.0;

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/abcscreen.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 50,right: 50,top: 50),
                width: phoneWidth,
                height: 220,
                decoration: BoxDecoration(
                  color: Color(0xFF69affe),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Say the correct letter when the ear appears.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTapDown: (_) =>
                              setState(() {
                                _paddingPlay = 0.0;
                              }),
                          onTapUp: (_) =>
                              setState(() {
                                _paddingPlay = 6.0;
                              }),
                          onTap: (){
                            bgAudio1.pause();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => abcgame()));
                          },
                          child: AnimatedContainer(
                            padding: EdgeInsets.only(bottom: _paddingPlay),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            duration: Duration(milliseconds: 100),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 13,horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                              ),
                              child: Text('PLAY',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )

          ],
        )
    );
  }
}

class abcgame extends StatefulWidget {
  const abcgame({Key? key}) : super(key: key);

  @override
  State<abcgame> createState() => _abcgameState();
}

class _abcgameState extends State<abcgame> {

  String letter = 'A';
  SpeechToText _speech = SpeechToText();
  Timer? _timer;
  String ear = 'assets/earoff.png';
  String voice = '';
  String _text = '';
  bool _isListening = false;
  int score = 0;
  bool displayEar = false;
  bool isRight = false;
  bool isWrong = false;
  String voiceGIF = 'assets/images/learnabc/a.gif';

  @override
  void initState() {
    _speech = stt.SpeechToText();
    LetterA();
    super.initState();
  }

  void LetterA() {
    setState(() {
      voice = 'The first letter in the alphabet is A. Can you pronounce the alphabet A?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningA();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterB();

      });
    });
  }

  void LetterB() {
    letter = 'B';
    voiceGIF = 'assets/images/learnabc/b.gif';
    setState(() {
      voice = 'The second letter in the alphabet is B. Can you pronounce the alphabet B?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningB();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterC();
      });
    });
  }

  void LetterC() {
    letter = 'C';
    voiceGIF = 'assets/images/learnabc/c.gif';
    setState(() {
      voice = 'The third letter in the alphabet is C. Can you pronounce the alphabet C?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningC();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterD();
      });
    });
  }

  void LetterD() {
    letter = 'D';
    voiceGIF = 'assets/images/learnabc/d.gif';
    setState(() {
      voice = 'The fourth letter in the alphabet is D. Can you pronounce the alphabet D?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningD();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterE();
      });
    });
  }

  void LetterE() {
    letter = 'E';
    voiceGIF = 'assets/images/learnabc/e.gif';
    setState(() {
      voice = 'The fifth letter in the alphabet is E. Can you pronounce the alphabet E?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningE();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterF();
      });
    });
  }

  void LetterF() {
    letter = 'F';
    voiceGIF = 'assets/images/learnabc/f.gif';
    setState(() {
      voice = 'The sixth letter in the alphabet is F. Can you pronounce the alphabet F?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningF();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterG();
      });
    });
  }

  void LetterG() {
    letter = 'G';
    voiceGIF = 'assets/images/learnabc/g.gif';
    setState(() {
      voice = 'The seventh letter in the alphabet is G. Can you pronounce the alphabet G?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningG();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterH();
      });
    });
  }

  void LetterH() {
    letter = 'H';
    voiceGIF = 'assets/images/learnabc/h.gif';
    setState(() {
      voice = 'The eighth letter in the alphabet is H. Can you pronounce the alphabet H?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningH();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterI();
      });
    });
  }

  void LetterI() {
    letter = 'I';
    voiceGIF = 'assets/images/learnabc/i.gif';
    setState(() {
      voice = 'The ninth letter in the alphabet is I. Can you pronounce the alphabet I?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningI();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterJ();
      });
    });
  }

  void LetterJ() {
    letter = 'J';
    voiceGIF = 'assets/images/learnabc/j.gif';
    setState(() {
      voice = 'The tenth letter in the alphabet is J. Can you pronounce the alphabet J?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningJ();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterK();
      });
    });
  }

  void LetterK() {
    letter = 'K';
    voiceGIF = 'assets/images/learnabc/k.gif';
    setState(() {
      voice = 'The eleventh letter in the alphabet is K. Can you pronounce the alphabet K?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningK();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterL();
      });
    });
  }

  void LetterL() {
    letter = 'L';
    voiceGIF = 'assets/images/learnabc/L.gif';
    setState(() {
      voice = 'The twelveth letter in the alphabet is L. Can you pronounce the alphabet L?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningL();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterM();
      });
    });
  }

  void LetterM() {
    letter = 'M';
    voiceGIF = 'assets/images/learnabc/m.gif';
    setState(() {
      voice = 'The thirteenth letter in the alphabet is M. Can you pronounce the alphabet M?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningM();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterN();
      });
    });
  }

  void LetterN() {
    letter = 'N';
    voiceGIF = 'assets/images/learnabc/n.gif';
    setState(() {
      voice = 'The fourteenth letter in the alphabet is N. Can you pronounce the alphabet N?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningN();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterO();
      });
    });
  }

  void LetterO() {
    letter = 'O';
    voiceGIF = 'assets/images/learnabc/o.gif';
    setState(() {
      voice = 'The fifteenth letter in the alphabet is O. Can you pronounce the alphabet O?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningO();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterP();
      });
    });
  }

  void LetterP() {
    letter = 'P';
    voiceGIF = 'assets/images/learnabc/p.gif';
    setState(() {
      voice = 'The sixteenth letter in the alphabet is P. Can you pronounce the alphabet P?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningP();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterQ();
      });
    });
  }

  void LetterQ() {
    letter = 'Q';
    voiceGIF = 'assets/images/learnabc/q.gif';
    setState(() {
      voice = 'The seventeenth letter in the alphabet is Q. Can you pronounce the alphabet Q?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningQ();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterR();
      });
    });
  }

  void LetterR() {
    letter = 'R';
    voiceGIF = 'assets/images/learnabc/r.gif';
    setState(() {
      voice = 'The eighteenth letter in the alphabet is R. Can you pronounce the alphabet R?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningR();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterS();
      });
    });
  }

  void LetterS() {
    letter = 'S';
    voiceGIF = 'assets/images/learnabc/s.gif';
    setState(() {
      voice = 'The nineteenth letter in the alphabet is S. Can you pronounce the alphabet S?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningS();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterT();
      });
    });
  }

  void LetterT() {
    letter = 'T';
    voiceGIF = 'assets/images/learnabc/t.gif';
    setState(() {
      voice = 'The twentieth letter in the alphabet is T. Can you pronounce the alphabet T?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningT();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterU();
      });
    });
  }

  void LetterU() {
    letter = 'U';
    voiceGIF = 'assets/images/learnabc/u.gif';
    setState(() {
      voice = 'The twenty-first letter in the alphabet is U. Can you pronounce the alphabet U?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningU();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterV();
      });
    });
  }

  void LetterV() {
    letter = 'V';
    voiceGIF = 'assets/images/learnabc/v.gif';
    setState(() {
      voice = 'The twenty-second in the alphabet is V. Can you pronounce the alphabet V?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningV();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterW();
      });
    });
  }

  void LetterW() {
    letter = 'W';
    voiceGIF = 'assets/images/learnabc/w.gif';
    setState(() {
      voice = 'The twenty-third letter in the alphabet is W. Can you pronounce the alphabet W?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningW();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterX();
      });
    });
  }

  void LetterX() {
    letter = 'X';
    voiceGIF = 'assets/images/learnabc/x.gif';
    setState(() {
      voice = 'The twenty-fourth letter in the alphabet is X. Can you pronounce the alphabet X?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningX();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterY();
      });
    });
  }

  void LetterY() {
    letter = 'Y';
    voiceGIF = 'assets/images/learnabc/y.gif';
    setState(() {
      voice = 'The twenty-fifth letter in the alphabet is Y. Can you pronounce the alphabet Y?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningY();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          isRight = false;
          isWrong = false;
        });
        LetterZ();
      });
    });
  }



  void LetterZ() {
    setState(() {
      voice = 'The twenty-sixth letter in the alphabet is Z. Can you pronunce the alphabet Z?';
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        displayEar = true;
      });
      _startListeningZ();
      Timer(Duration(milliseconds: 12000),() {
        setState(() {
          voiceGIF = 'assets/images/learnabc/z.gif';
          isRight = false;
          isWrong = false;
        });
        saveData();
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => congratsScreen(score: score.toString())));
      });
    });
  }

  void _startListeningZ() async {

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
        String e = "z";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningY() async {

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
        String e = "y";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningX() async {

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
        String e = "x";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningW() async {

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
        String e = "w";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningV() async {

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
        String e = "v";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningU() async {

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
        String e = "u";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningT() async {

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
        String e = "t";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningS() async {

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
        String e = "s";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningR() async {

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
        String e = "r";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningQ() async {

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
        String e = "q";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningP() async {

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
        String e = "p";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningO() async {

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
        String e = "o";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningN() async {

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
        String e = "n";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningM() async {

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
        String e = "m";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningL() async {

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
        String e = "l";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningK() async {

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
        String e = "g";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningJ() async {

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
        String e = "j";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningI() async {

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
        String e = "i";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningH() async {

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
        String e = "h";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningG() async {

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
        String e = "g";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningF() async {

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
        String e = "f";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningE() async {

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
        String e = "e";
        print(splitText);
        if(splitText.any((element) => e.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningD() async {

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
        String d = "d";
        print(splitText);
        if(splitText.any((element) => d.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningC() async {

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
        String c = "c";
        print(splitText);
        if(splitText.any((element) => c.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningB() async {

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
        String b = "b";
        print(splitText);
        if(splitText.any((element) => b.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void _startListeningA() async {

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
        String a = "a";
        print(splitText);
        if(splitText.any((element) => a.contains(element)) && _text.isNotEmpty){
          score = score + 3;
          setState(() {
            displayEar = false;
            isRight = true;
          });
        }else if (_text.isEmpty){
          setState(() {
            displayEar = false;
            isWrong = true;
          });
          score = score + 0;
        }else{
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

  void saveData() async {
    print('test1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('sda' + score.toString());
    prefs.setInt("scoreKeyABC", score);
    print('test2');
  }

  void _stopListening() {
    _speech.stop();

    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/abc.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.7),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(letter,style: TextStyle(
                                fontSize: 80
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.7),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              voiceGIF,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),

                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.7),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: 50,
                  child: Center(
                    child: Text(voice,style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
          displayEar ? Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6)
                  ),
                  child: Center(
                    child: Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/ear.gif')
                    ),
                  ),
                ),
              ),
            ],
          ) : SizedBox(),
          isRight ? Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6)
                  ),
                  child: Center(
                    child: Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/check.gif')
                    ),
                  ),
                ),
              ),
            ],
          ) : SizedBox(),
          isWrong ? Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6)
                  ),
                  child: Center(
                    child: Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/wrong.gif')
                    ),
                  ),
                ),
              ),
            ],
          ) : SizedBox(),
        ],
      ),
    );
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
