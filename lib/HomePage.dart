import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //TODO: IMPORT IMAGES
  AssetImage circle=AssetImage('images/circle.png');
  AssetImage rupee=AssetImage('images/rupee.png');
  AssetImage sad=AssetImage('images/sadFace.png');

  int luckyNumber=-1;
  List<String> gameState=List.filled(25, 'empty');
  int noOfAttempts=0;
  String message="";

  @override
  void initState(){
    super.initState();
    generateRandomNumber();
  }
  
  //TODO: DEFINE A GET IMAGE METHOD
  AssetImage getImage(String val){
    if(val=="empty") {
      return circle;
    } else if(val=="rupee") {
      return rupee;
    } else if(val=="sad") {
      return sad;
    }
    return circle;
  }

  //TODO: GENERATE RANDOM NUMBER
  void generateRandomNumber(){
    int rand=Random().nextInt(24);
    setState(() {
      luckyNumber=rand;
    });
    // print(luckyNumber);
  }

  //TODO: PLAY GAME METHOD
  void playGame(int index){
    if(message.isNotEmpty) {
      return;
    }
    if(noOfAttempts==5) {
      setState(() {
        message="No More Attempts Left!";
      });
      return;
    }
    noOfAttempts++;
    setState(() {
      gameState[index]= index==luckyNumber ? "rupee" : "sad";
      if(index==luckyNumber) {
        message="Congratulations!!";
      }
    });
  }


  //TODO: SHOW ALL
  void showAll(){
    setState(() {
      gameState=List.filled(25, "sad");
      gameState[luckyNumber]="rupee";
    });
  }


  //TODO: RESET ALL
  void resetAll(){
    setState(() {
      gameState=List.filled(25, "empty");
      generateRandomNumber();
      noOfAttempts=0;
      message="";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Scratch and Win")
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Expanded(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,  //? cross axis --> left to right, .. 5 items per row
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0
                  ),
                  itemCount: 25,
                  itemBuilder: (context,i) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.3,
                      ),
                    ),
                    height: 40, 
                    width: 40,
                    child: ElevatedButton(
                      onPressed: (){playGame(i);},
                      child: Image(
                        image: getImage(gameState[i])
                      ),
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.grey[200])),
                    ),
                  ) 
                ),

                Container(
                  margin:const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(message.toUpperCase(), style:const TextStyle(fontSize: 20, color:Colors.lightBlue, backgroundColor: Colors.amber, fontFamily: 'OpenSans', fontWeight: FontWeight.w900))
                ),

                Container(
                  margin:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ElevatedButton(
                    onPressed: (){showAll();},
                    child: const Text("Show All", style: TextStyle(fontSize: 20)),
                    style:ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),  // width=inifinty, height=50
                    )
                  ),
                ),

                Container(
                  margin:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ElevatedButton(
                    onPressed: (){resetAll();},
                    child: const Text("Reset All", style: TextStyle(fontSize: 20)),
                    style:ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),  //width=infinity, height=50
                    )
                  ),
                )

              ],
            ),
          ),

          Container(
            color: Colors.black,
            child:const Align(
              alignment: Alignment.center,
              child: Text("Made by Charmi \u2665", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))
            ),
            width: double.infinity,
            height:40
          )

        ],
      )

    );
  }
}