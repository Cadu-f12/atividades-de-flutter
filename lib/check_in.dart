import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CheckInPage(), debugShowCheckedModeBanner: false,));
}

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInState();
}

class CheckInState extends State<CheckInPage> {
  int currentActivatedBtn = 1;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String? _validatorEmailField(String? email) {
    if (email == null || email.isEmpty) {
      return "O email está vazio";
    }

    if (email.length < 4) {
      return "O email é muito pequeno para ser aceito";
    }

    bool notEmail = true;
    for (int i = 0; i < email.length; i++) {
      if (email[i] == "@") {
        notEmail = false;
      }
    }
    if (notEmail) {
      return "Isso não é um email";
    }

    return null;
  }

  String? _validatorCode(String? code) {
    if (code == null || code.isEmpty) {
      return "Seu código está vazio";
    }

    if (code.length < 5) {
      return "O código deve ser maior que 4 caracteres";
    }

    return null;
  }

  void _submitButtonPressed() {
    if (formKey.currentState!.validate()) {
      print("nononon");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: _checkInContainer(),
          ),
        ) 
      ),
    );
  }

  Widget _checkInContainer() {
    return Container(
      margin: EdgeInsets.all(100),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))
            ),
            child: Container(
              padding: EdgeInsets.only(top: 80, bottom: 0, left: 0, right: 0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "🚀 WorkShop Flutter",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
            ),
            child: Container(
              padding: EdgeInsets.only(top: 0, bottom: 150, left: 0, right: 0),
              child: Form(
                key: formKey,
                child: _formsOfChekIn()
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _formsOfChekIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fieldsOfCheckIn("E-MAIL DE INSCRITO", "Digite seu email aqui", Icons.mail, _validatorEmailField),
        SizedBox(height: 20,),
        _fieldsOfCheckIn("CÓDIGO DO TICKET", "Digite seu código aqui", Icons.search, _validatorCode),
        SizedBox(height: 20,),
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Text(
            "TIPO DE CREDENCIAL"
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _checkInButton(1, "Estudante"),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: _checkInButton(2, "Profissional")
            )
          ],
        ),
        SizedBox(height: 20,),
        ElevatedButton(
          onPressed: _submitButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            "🎟️ Realizar Check-in Agora",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _fieldsOfCheckIn(String title, String labelText, IconData icon, String? Function(String?) validatorFunction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: Icon(icon),
          ),
          validator: validatorFunction,
        )
      ],
    );
  }

  Widget _checkInButton(int id, String text) {
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;

    if (id == currentActivatedBtn) {
      backgroundColor = Colors.blueAccent;
      textColor = Colors.white;
    }

    return OutlinedButton(
      onPressed: () => {
        setState(() {
          currentActivatedBtn = id;
        })
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(5))
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }

}
