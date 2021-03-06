import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/custom_dialog.dart';
import 'package:tictactoe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var player1;
  var player2;
  var activePlayer;
  bool computer =false;
   

  List<GameButton> buttonList;
  
  @override
  void initState(){
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit(){
     player1= new List();
     player2= new List();
     activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb){
    setState(() {
      if(activePlayer == 1){
        gb.text = "X";
        gb.bg=Colors.tealAccent;
        activePlayer=2;
        player1.add(gb.id);
      } else
//       if(computer == true) {
 //       gb.text = "0";
//        gb.bg = Colors.white;
//        activePlayer=1;
 //       player2.add(gb.id);     } 
 //     else
       {
        gb.text = "0";
        gb.bg = Colors.white;
        activePlayer=1;
        player2.add(gb.id);
      }
      gb.enabled = false;
    
      checkWinner();
     
      
      //if(winner == -1){
       // if(buttonList.every((p) => p.text !=" ")){
        //  showDialog(
         //   context: context,
         //  builder: (_) => new CustomDialog("Game Tied","Press the reset button to start again", resetGame)
         //   );}
           // else{
         // if(activePlayer==2)
       //  {
        //   if(computer==true)
         //   {autoPlay();}
        //  }
       // }
     // }
    });
  }

  

  void autoPlay(){
    var emptyCells = new List();
    var list= new List.generate(9, (i)=>i+1);
    for(var cellID in list){
      if(!(player1.contains(cellID) || player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }

    var r=new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i= buttonList.indexWhere((p) => p.id == cellID);
    playGame(buttonList[i]);
  }

 

void checkWinner(){
    var winner=-1;
    if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner=1;
    }

    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if(winner !=-1){
      if(winner == 1){
        showDialog(
          context: context,
          builder: (_) => new CustomDialog("Player 1 Won","Press the reset button to start again", resetGame));
      }else{
        showDialog(
          context: context,
          builder: (_) => new CustomDialog("Player 2 Won","Press the reset button to start again", resetGame));
      }
    }
    /*else{if(buttonList.every((p) => p.text !=" ")){
          showDialog(
           context: context,
           builder: (_) => new CustomDialog("Game Tied","Press the reset button to start again", resetGame)
            );}
    }*/
    
  }

  void resetGame(){
    if(Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:new Text("TIC TAC TOE"),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
                        child: new GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0
                ),
              padding: const EdgeInsets.all(12.0),
              itemCount: buttonList.length,
              itemBuilder: (context,i) => new SizedBox(
                width: 100.0,
                height: 100.0,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonList[i].enabled
                             ? () => playGame(buttonList[i])
                             : null,
                  child: new Text(
                    buttonList[i].text,
                    style: new TextStyle(color: Colors.black87,fontSize: 60.0),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                  ),
              ),
          ),
            ),
 //              new RaisedButton(
 //             child: new Text(
  //              "COMPUTER",
  //              style: new TextStyle(color: Colors.black,fontSize: 20.0),
  //            ),
  //            color: Colors.indigo,
 //             padding: const EdgeInsets.all(20.0),
  //            onPressed: (){ computer = true;},
  //           ),
            new RaisedButton(
              child: new Text(
                "RESET",
                style: new TextStyle(color: Colors.black,fontSize: 20.0),
              ),
              color: Colors.indigo,
              padding: const EdgeInsets.all(20.0),
              onPressed: resetGame,
             )
          ],       
        ),
    );
  }
}