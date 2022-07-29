import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictacteo/Logic/GameLogic.dart';
import 'package:tictacteo/widgets/Compontets.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitch = false;
  String activePlayer = 'X';
  String result = "";
  bool gameOver = false;
  int turn = 0;
  Game game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...FirstBlock(),
                  buildExpanded(),
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...FirstBlock(),
                      ...lastBlock(),
                    ],
                  )
                  ),
                  buildExpanded(),
                ],
              ),
      ),
    );
  }

  List<Widget> FirstBlock() {
    return [
      defaultPadding(
          padding: 16.0,
          widget: SwitchListTile.adaptive(
              activeColor: Colors.redAccent,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.amber,
              inactiveThumbColor: Colors.amberAccent,
              title: defaultText(
                  text: "Turn on/off 2 Players",
                  color: Colors.white,
                  fSize: 25),
              value: isSwitch,
              onChanged: (bool newValue){
                setState(() {
                  isSwitch = newValue;
                });
              })),
         defaultPadding(
             padding: 10.0,
             widget: defaultText(
                 text: "it's $activePlayer turn".toUpperCase(), color: Colors.white, fSize: 40))
    ];
  }

  Expanded buildExpanded(){
    return Expanded(
        child: GridView.count(
          padding: const EdgeInsets.all(16.0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1,
            crossAxisCount: 3,
            children: List.generate(
                9, 
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: gameOver ? null : () => _onTap(index),
                      child: Container(
                        decoration: defaultDecoration(),
                        child: Center(
                          child: Player.playerX.contains(index) ?
                          defaultText(text: 'X', color: Colors.blue, fSize: 40)
                          : Player.playerO.contains(index) ?
                          defaultText(text: 'O', color: Colors.white, fSize: 40)
                          : Container(),
                        ),
                      ),
            )),
        ));
  }


  List<Widget> lastBlock(){
    return [
      defaultPadding(
          padding: 100.0,
          widget: defaultText(text: result, color: Colors.redAccent, fSize: 15)),
      ElevatedButton.icon(
          onPressed: (){
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = " ";
          },
           icon: const Icon(Icons.replay),
           label: Text("Repeate The Game"),
           style: ButtonStyle(
             backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
           ),
          ),
    ];
  }


  _onTap(int index) async{
    if((Player.playerX.isEmpty || Player.playerX.contains(index)) && (Player.playerO.isEmpty || Player.playerO.contains(index))){
      game.playGame(index, activePlayer);
      updateLogic();
    }

    if(!isSwitch && !gameOver && turn != 9){
      await game.autoPlayer(activePlayer);
      updateLogic();
    }
  }


  void updateLogic(){
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      turn++;

      String winnerPlayer = game.checkWinner();
      if(winnerPlayer != ''){
        gameOver = true;
        result = '$winnerPlayer is the Winner';
      } else if(!gameOver && turn == 9) result = 'It\'s a Draw';
    });
  }
}
