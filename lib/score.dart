import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scoreScreenAdventure extends StatefulWidget {


  @override
  State<scoreScreenAdventure> createState() => _scoreScreenAdventureState();
}

class _scoreScreenAdventureState extends State<scoreScreenAdventure> {

  int? score1;
  int? score2;
  int? score3;
  int? scoreDis1;
  int? scoreDis2;
  int? scoreDis3;


  @override
  void initState() {
    print("ha");
    scoreDisplay();

    super.initState();
  }

  void scoreDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    score1 = prefs.getInt("scoreKeyStory1");
    score2 = prefs.getInt("scoreKeyStory2");
    score3 = prefs.getInt("scoreKeyStory3");
    print(score1);
    setState(() {
      scoreDis1 = score1 ?? 0;
      scoreDis2 = score2 ?? 0;
      scoreDis3 = score3 ?? 0;
    });
  }

  @override
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
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenMemory()));
              },
              child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 10, top: 70),
                  child: Image.asset('assets/images/right.png'))),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenABC()));
                },
                child: Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10, top: 70),
                    child: Image.asset('assets/images/left.png'))),
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 260,
                width: 550,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/scoreboard.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 45),
                                width: 70,
                                child: Image.asset('assets/images/adventurestory.png')
                            ),
                            SizedBox(width: 20,),
                            Container(
                              height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                    'Story 1',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDis1.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                    fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                  'Story 2',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDis2.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                  'Story 3',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDis3.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class scoreScreenMemory extends StatefulWidget {


  @override
  State<scoreScreenMemory> createState() => _scoreScreenMemoryState();
}

class _scoreScreenMemoryState extends State<scoreScreenMemory> {

  int? scoreEasy;
  int? scoreMed;
  int? scoreHard;
  int? scoreDisEasy;
  int? scoreDisMed;
  int? scoreDisHard;


  @override
  void initState() {
    print("ha");
    scoreDisplay();

    super.initState();
  }

  void scoreDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    scoreEasy = prefs.getInt("scoreEasyMemory");
    scoreMed = prefs.getInt("scoreMediumMemory");
    scoreHard = prefs.getInt("scoreHardMemory");
    print(scoreEasy);
    setState(() {
      scoreDisEasy = scoreEasy ?? 0;
      scoreDisMed = scoreMed ?? 0;
      scoreDisHard = scoreHard ?? 0;
    });
  }

  @override
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
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenABC()));
                },
                child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 10, top: 70),
                    child: Image.asset('assets/images/right.png'))),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenAdventure()));
                },
                child: Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10, top: 70),
                    child: Image.asset('assets/images/left.png'))),
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 260,
                width: 550,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/scoreboard.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 45),
                                width: 70,
                                child: Image.asset('assets/images/matchmemory.png')
                            ),
                            SizedBox(width: 20,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                  'Easy',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDisEasy.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                  'Medium',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDisMed.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text(
                                  'Hard',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDisHard.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),


                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class scoreScreenABC extends StatefulWidget {


  @override
  State<scoreScreenABC> createState() => _scoreScreenABCState();
}

class _scoreScreenABCState extends State<scoreScreenABC> {

  int? score1;
  int? score2;
  int? score3;
  int? scoreDis1;
  int? scoreDis2;
  int? scoreDis3;



  @override
  void initState() {
    print("ha");
    scoreDisplay();

    super.initState();
  }

  void scoreDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    score1 = prefs.getInt("scoreKeyABC");

    print(score1);
    setState(() {
      scoreDis1 = score1 ?? 0;
      scoreDis2 = score2 ?? 0;
      scoreDis3 = score3 ?? 0;
    });
  }

  @override
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
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenAdventure()));
                },
                child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 10, top: 70),
                    child: Image.asset('assets/images/right.png'))),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => scoreScreenMemory()));
                },
                child: Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10, top: 70),
                    child: Image.asset('assets/images/left.png'))),
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 260,
                width: 550,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/scoreboard.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 45),
                                width: 70,
                                child: Image.asset('assets/images/learnabc.png')
                            ),
                            SizedBox(width: 20,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),
                            SizedBox(width: 140,),
                            Column(
                              children: [
                                Text(
                                  'Score',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  scoreDis1.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 140,),
                            Container(
                                height: 120,
                                child: Image.asset('assets/images/chalk.png')
                            ),



                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}