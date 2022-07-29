import 'dart:math';

class Player{
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}
extension ContainsAll on List{
  bool containsAll(int x, int y, [z]) {
    if(z==null) return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}


class Game{

  void playGame(int index, String activePalyer){
    if(activePalyer == 'X'){
      Player.playerX.add(index);
    }else{
      Player.playerO.add(index);
    }
  }

  String checkWinner(){
    String winner = ' ';
    if(Player.playerX.containsAll(0,1,2) ||
       Player.playerX.containsAll(3,4,5) ||
       Player.playerX.containsAll(6,7,8) ||
       Player.playerX.containsAll(0,3,6) ||
       Player.playerX.containsAll(1,4,7) ||
       Player.playerX.containsAll(2,5,8) ||
       Player.playerX.containsAll(0,4,8) ||
       Player.playerX.containsAll(2,4,6))
      {
       winner = 'X';
      }else if(Player.playerO.containsAll(0,1,2) ||
        Player.playerO.containsAll(3,4,5) ||
        Player.playerO.containsAll(6,7,8) ||
        Player.playerO.containsAll(0,3,6) ||
        Player.playerO.containsAll(1,4,7) ||
        Player.playerO.containsAll(2,5,8) ||
        Player.playerO.containsAll(0,4,8) ||
        Player.playerO.containsAll(2,4,6))
      {
      winner = 'O';
      }else {
      winner = '';
    }
    return winner;
  }


  Future<void> autoPlayer(activePlayer)async{
    int index = 0;
    List<int> emptyCells = [];

    for(int i = 0; i<9 ; i++){
      if(!(Player.playerX.contains(i) || Player.playerO.contains(i))){
        emptyCells.add(i);
      }
    }

    if (emptyCells.contains(0) &&(Player.playerO.containsAll(1,2) || Player.playerO.containsAll(3,6) || Player.playerO.containsAll(4,8))) {
      index = 0;
    }
    else if (emptyCells.contains(1) &&(Player.playerO.containsAll(0,2) || Player.playerO.containsAll(4,7))) {
      index = 1;
    }
    else if (emptyCells.contains(2) &&(Player.playerO.containsAll(0,1) || Player.playerO.containsAll(5,8) || Player.playerO.containsAll(4,6))) {
      index = 2;
    }
    else if (emptyCells.contains(3) &&(Player.playerO.containsAll(0,6) || Player.playerO.containsAll(4,5))) {
      index = 3;
    }
    else if (emptyCells.contains(4) &&(Player.playerO.containsAll(1,7) || Player.playerO.containsAll(3,5) || Player.playerO.containsAll(0,8)|| Player.playerO.containsAll(2,6))) {
      index = 4;
    }
    else if (emptyCells.contains(5) &&(Player.playerO.containsAll(2,8) || Player.playerO.containsAll(3,4))) {
      index = 5;
    }
    else if (emptyCells.contains(6) &&(Player.playerO.containsAll(0,3) || Player.playerO.containsAll(7,8)|| Player.playerO.containsAll(2,4))) {
      index = 6;
    }
    else if (emptyCells.contains(7) &&(Player.playerO.containsAll(1,4) || Player.playerO.containsAll(6,8))) {
      index = 7;
    }
    else if (emptyCells.contains(8) &&(Player.playerO.containsAll(2,5) || Player.playerO.containsAll(6,7)|| Player.playerO.containsAll(0,4))) {
      index = 8;
    }

    else if (emptyCells.contains(0) &&(Player.playerX.containsAll(1,2) || Player.playerX.containsAll(3,6) || Player.playerX.containsAll(4,8))) {
      index = 0;
    }
    else if (emptyCells.contains(1) &&(Player.playerX.containsAll(0,2) || Player.playerX.containsAll(4,7))) {
      index = 1;
    }
    else if (emptyCells.contains(2) &&(Player.playerX.containsAll(0,1) || Player.playerX.containsAll(5,8) || Player.playerX.containsAll(4,6))) {
      index = 2;
    }
    else if (emptyCells.contains(3) &&(Player.playerX.containsAll(0,6) || Player.playerX.containsAll(4,5))) {
      index = 3;
    }
    else if (emptyCells.contains(4) &&(Player.playerX.containsAll(1,7) || Player.playerX.containsAll(3,5) || Player.playerX.containsAll(0,8)|| Player.playerX.containsAll(2,6))) {
      index = 4;
    }
    else if (emptyCells.contains(5) &&(Player.playerX.containsAll(2,8) || Player.playerX.containsAll(3,4))) {
      index = 5;
    }
    else if (emptyCells.contains(6) &&(Player.playerX.containsAll(0,3) || Player.playerX.containsAll(7,8)|| Player.playerX.containsAll(2,4))) {
      index = 6;
    }
    else if (emptyCells.contains(7) &&(Player.playerX.containsAll(1,4) || Player.playerX.containsAll(6,8))) {
      index = 7;
    }
    else if (emptyCells.contains(8) &&(Player.playerX.containsAll(2,5) || Player.playerX.containsAll(6,7)|| Player.playerX.containsAll(0,4))) {
      index = 8;
    }

    else{
     Random random = Random();
     int randomIndex = random.nextInt(emptyCells.length);
     index = emptyCells[randomIndex];
    }
    playGame(index, activePlayer);
  }
}
