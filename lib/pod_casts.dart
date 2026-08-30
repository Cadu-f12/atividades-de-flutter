import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DevsEmFocoPage(), debugShowCheckedModeBanner: false));
}

class DevsEmFocoPage extends StatefulWidget {
  const DevsEmFocoPage({super.key});

  @override
  State<StatefulWidget> createState() => DevsEmFocoState();

}

class DevsEmFocoState extends State<StatefulWidget> {
  int currentActiveButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: _devsContainer()
        ),
      ),
    );
  }

  Widget _devsContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _podcastSummary(),
          SizedBox(height: 15,),
        _podcastPanel()
        ],
      ),
    );
  }

  Widget _podcastSummary() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 40, right: 60, left: 20, bottom: 30),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _summaryText("🎙️ Devs em Foco", true),
              SizedBox(height: 10,),
              _summaryText("Episódio 12 - Arquitetura e UI em Flutter", false)
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.only(top: 12, right: 12),
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(25)
            ),
            child: Text(
              "🔴 AO VIVO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _podcastPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "VELOCIDADE DA REPRODUÇÃO",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 15,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buttonPanel(1, "1.0x", false),
            SizedBox(width: 10,),
            _buttonPanel(2, "1.25x", true),
            SizedBox(width: 10,),
            _buttonPanel(3, "1.5x", false),
             SizedBox(width: 10,),
            _buttonPanel(4, "2.0x", false)
          ],
        )
      ],
    );
  }

  Widget _summaryText(String text, bool isTitle) {
    if (isTitle) {
      return Text(
        text,
        style: TextStyle(
          color: const Color.fromARGB(237, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      );
    }
    
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(160, 255, 255, 255)
      ),
    );
  }

  Widget _buttonPanel(int identity, String text, bool isActive) {
    Color backgroundColor = Colors.white;
    Color foregroundColor = Colors.blueGrey;
    
    if (identity == currentActiveButton) {
      backgroundColor = Colors.blue;
      foregroundColor = Colors.white;
    }

    return OutlinedButton(
      onPressed: () => {setState(() {
        currentActiveButton = identity;
      })}, 
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(
          color: Colors.blueGrey
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5)
        ),
        foregroundColor: foregroundColor
      ),
      child: Text(text),
    );
  }
}