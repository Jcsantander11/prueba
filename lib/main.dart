import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

//CLASE PREGUNTAS 
class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex = 0;
  _QuizPageState();
  List<Question> _questions = [
    Question(
      '¿Cuál es el numero que observas en pantalla?',
      ['8', '6', '3', '9'],
      0,
    ),
    Question(
      '¿Cuál es el numero que observas en pantalla?',
      ['8', '6', '3', '9'],
      1,
    ),
    Question(
      '¿Cuál es el numero que observas en pantalla?',
      ['8', '6', '3', '9'],
      2,
    ),
    Question(
      '¿Cuál es el numero que observas en pantalla?',
      ['8', '6', '3', '9'],
      3,
    ),
    ];

  //APPBAR DEL CUESTIONARIO
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('COLOR BLINDNESS TEST', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      //CUERPO CUESTIONARIO
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //Container Imagen QUIZ
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Image.asset('assets/2.png', width: 350,height: 300,),
          ),
          
          //Container pregunta QUIZ
          Container(
            margin: EdgeInsets.all(12),
              child: Text(
                _questions[_currentQuestionIndex].question,
                style: TextStyle(fontSize: 25),
            ),
          ),
          
          //CAJA RESPUESTAS (4)
         Container(
            margin: EdgeInsets.only(left: 50, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: _questions[_currentQuestionIndex]
                      .answers
                      .asMap()
                      .entries
                      .where((entry) => entry.key < (_questions[_currentQuestionIndex].answers.length / 2).ceil())
                      .map(
                        (entry) => Expanded(
                          child: RadioListTile(
                            title: Text(
                              entry.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            value: entry.key,
                            groupValue: _selectedAnswerIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedAnswerIndex = value;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  children: _questions[_currentQuestionIndex]
                      .answers
                      .asMap()
                      .entries
                      .where((entry) => entry.key >= (_questions[_currentQuestionIndex].answers.length / 2).ceil())
                      .map(
                        (entry) => Expanded(
                          child: RadioListTile(
                            title: Text(
                              entry.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            value: entry.key,
                            groupValue: _selectedAnswerIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedAnswerIndex = value;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          

          //__________________________________________________________________________--
          MaterialButton(
            onPressed: () {
              
              //VENTANA SELECCIONAR RESPUESTA
              if (_selectedAnswerIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selecciona una respuesta', textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              }

              //VENTANA SELECCIONAR RESPUESTA CORRECTA
              if (_questions[_currentQuestionIndex].correctAnswerIndex ==
                  _selectedAnswerIndex) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('¡Respuesta correcta!', textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              } 
              
              //VENTANA SELECCIONAR RESPUESTA INCORRECTA
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Respuesta incorrecta',textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                    backgroundColor: Colors.red,
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              }
              //VENTANA FIN QUIZ
              setState(() {
                _selectedAnswerIndex = null;
                if (_currentQuestionIndex < _questions.length - 1) {
                  _currentQuestionIndex++;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fin del quiz :)', textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  _currentQuestionIndex = 0;
                }
              });
            },

            //BOTON SIGUIENTE 
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Siguiente', style: TextStyle(fontSize: 25, color: Colors.white),),
          ),

          //BOTON REINICIAR
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      '¿Está seguro de reiniciar la prueba?', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.green),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _currentQuestionIndex = 0;
                            _selectedAnswerIndex = null;
                          });
                        },
                        child: Text('Sí', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Reiniciar',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 37, 182, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.question, this.answers, this.correctAnswerIndex);
}

