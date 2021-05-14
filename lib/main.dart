import 'dart:ui';
import 'package:flutter/material.dart';

/*
//CODE BY:
//ORLANDO LEITE ROLIM FILHO
*/

void main() => runApp(
  MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ),
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0), child: buildForm()
      )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutIMC()),
            );
          }
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (imc <= 18.5)
        _result += "Magreza";
      else if (imc >= 18.5 && imc <= 24.9)
        _result += "Normal";
      else if (imc >= 25.0 && imc <= 29.9)
        _result += "Sobrepeso";
      else if (imc >= 30.0 && imc <= 39.9)
        _result += "Obesidade";
      else if (imc < 40.0)
        _result += "Obesidade Grave";
    });
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Calcular",style: TextStyle(color: Colors.black)),
            onPressed: (){
              if(_formKey.currentState.validate()){
                calculateImc();
              }
            }
          ),
          SizedBox(width: 5),
          RaisedButton(
            child: Text("Limpar", style: TextStyle(color: Colors.red)),
            onPressed: () {
              resetFields();
            },
          ),
        ],
      ),
    );
  }
  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget buildTextFormField({TextEditingController controller, String error, String label}){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}

//-----------------PAGINA SOBRE-----------------------//
class AboutIMC extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sobre IMC',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Sobre IMC'),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                '\n    IMC é a sigla para Índice de Massa Corpórea, parâmetro adotado pela Organização Mundial de Saúde para calcular o peso ideal de cada pessoa.\n\n    O índice é calculado da seguinte maneira:\n    Divide-se o peso do paciente pela sua altura elevada ao quadrado. Diz-se que o indivíduo tem peso normal quando o resultado do IMC está entre 18,5 e 24,9.\n\n    Quer descobrir seu IMC?\n    Insira seu peso e sua altura nos campos do app, na pagina principal.',
                textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 120.0),
                child: RaisedButton(
                  child: Text("Voltar",style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home())
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}