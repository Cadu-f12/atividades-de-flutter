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
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool checkInConfirmed = false;
  String? emailMessage = "";
  String? codeMessage = "";


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
      return "Código de ticket meuito curto (mínimo 5 caracteres).";
    }

    return null;
  }

  void _submitButtonPressed() {
    setState(() {
      emailMessage = _validatorEmailField(emailController.text);
      codeMessage = _validatorCode(codeController.text);
    });
    

    if (formKey.currentState!.validate()) {
      print(emailController.text);
      print(codeController.text);
      setState(() {
        
        checkInConfirmed = true;
        
      });

      return;
    }

    if (checkInConfirmed) {
      checkInConfirmed = false;
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
              padding: EdgeInsets.only(top: 75, bottom: 0, left: 0, right: 0),
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
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
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
        _fieldsOfCheckIn("E-MAIL DE INSCRITO", "Digite seu email aqui", Icons.mail, _validatorEmailField, emailController),
        SizedBox(height: 20,),
        _fieldsOfCheckIn("CÓDIGO DO TICKET", "Digite seu código aqui", Icons.search, _validatorCode, codeController),
        SizedBox(height: 20,),
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Text(
            "TIPO DE CREDENCIAL",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 5,),
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
        SizedBox(height: 15,),
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
        ),
        if (emailMessage != null || codeMessage != null) ...[
          SizedBox(height: 20),

          Column(
            children: [
              if (emailMessage != null)
                Text(
                  emailMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              if (codeMessage != null)
                Text(
                  codeMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
        if (checkInConfirmed) ...[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20,top: 20, bottom: 5),
            child: Row(
              children: [
                Icon(Icons.circle, color: Colors.green,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-in Confirmado!",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Credencial de Estudante Liberada.",
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]
      ],
    );
  }

  Widget _fieldsOfCheckIn(String title, String labelText, IconData icon, String? Function(String?) validatorFunction, TextEditingController controllerFunction) {
    Color colorOfField = Colors.grey.shade600;
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorOfField.withAlpha(90),
        width: 1.0
      )
    );
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorOfField,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5,),
        TextFormField(
          controller: controllerFunction,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: colorOfField
            ),
            suffixIcon: Icon(icon),

            enabledBorder: border,
            errorBorder: border,

            focusedErrorBorder: focusedBorder,
            focusedBorder: focusedBorder,

            errorStyle: TextStyle(
              height: 0,
              fontSize: 0,
            )
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
