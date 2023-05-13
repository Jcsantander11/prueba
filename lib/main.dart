import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

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

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _isAnswerCorrect = false;
  bool _isQuizFinished = false;

  final List<Question> questions = [
    //LAMINAS DE PATRON DE TRANSFORMACION 
    //PERSONAS CON VISION NORMAL VERAN UN NUMERO
    //PERSONAS CON DISCROMATOPSIA CONGENITA (COLOR VERDE Y ROJO) VERAN UN NUMERO DIFERENTE
    //
    //HACER LAS CONDICIONALES DE LA SIGUIENTE MANERA: 
    //1) SI LA PERSONA SE EQUIVOCA EN POR LO MENOS EN UN TIENE 
    //PROBLEMAS EN DETECTAR EL COLOR VERDE Y ROJO
    //2) SI LA PERSONA SE EQUIVOCA EN TODAS TIENE CEGERA TOTAL
    //3) SI LA PERSONA ACIERTA TODAS, NO TIENE NINGUN PROBLEMA DE DALTONISMO\\
    Question(
      image: 'assets/images/2.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['8', '3', '6', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/12.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['82', '97', '31', 'Ninguno'],
      correctOption: 1,
    ),
    Question(
      image: 'assets/images/10.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['1', '7', '2', 'Ninguno'],
      correctOption: 2,
    ),
    Question(
      image: 'assets/images/13.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['48', '13', '45', 'Ninguno'],
      correctOption: 2,
    ),
    Question(
      image: 'assets/images/5.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['57', '35', '65', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/11.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['6', '8', '5', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/8.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['17', '15', '73', 'Ninguno'],
      correctOption: 1,
    ),
    Question(
      image: 'assets/images/14.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['2', '5', '3', 'Ninguno'],
      correctOption: 1,
    ),
        Question(
      image: 'assets/images/16.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['16', '75', '18', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/6.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['5', '2', '3', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/15.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['1', '7', '2', 'Ninguno'],
      correctOption: 1,
    ),
    Question(
      image: 'assets/images/9.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['74', '24', '21', 'Ninguno'],
      correctOption: 0,
    ),
    Question(
      image: 'assets/images/7.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['8', '5', '3', 'Ninguno'],
      correctOption: 2,
    ),
    Question(
      image: 'assets/images/4.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['73', '70', '29', 'Ninguno'],
      correctOption: 2,
    ),
    Question(
      image: 'assets/images/17.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['58', '15', '73', 'Ninguno'],
      correctOption: 2,
    ),
    Question(
      image: 'assets/images/3.jpg',
      text: '¿Que numero logras observar en pantalla?',
      options: ['5', '6', '8', 'Ninguno'],
      correctOption: 1,
    ),
  ];

  //----
void _checkAnswer(int selectedOptionIndex) {
    if (selectedOptionIndex == questions[_currentQuestionIndex].correctOption) {
      _isAnswerCorrect = true;
      _correctAnswers++;
    } else {
      _isAnswerCorrect = false;
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _isQuizFinished = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            correctAnswers: _correctAnswers,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  //-------------------

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex == questions[_currentQuestionIndex].correctOption) {
      setState(() {
        _correctAnswers++;
      });
      _showSnackBar('✓');
    } else {
      _showSnackBar('✘');
    }

    if (_currentQuestionIndex == questions.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            correctAnswers: _correctAnswers,
            totalQuestions: questions.length,
          ),
        ),
      );
    } else {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }
  
//---------------------------------------------

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(

      //SNACK VENTANA EMERGENTE RESPUESTA
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 250),
        backgroundColor: Colors.blueGrey[300],
      ),
    );
  }
//---------------------------------------------

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //TITULO QUIZ
      appBar: AppBar(
        title: Text(
          'COLOR BLINDNESS TEST',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        ),


      //CUERPO QUIZ
      body: _currentQuestionIndex < questions.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //CONTAINER IMAGEN QUIZ
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Image.asset(
                    questions[_currentQuestionIndex].image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),


                //CONTAINER PREGUNTA QUIZ
                Container(
                 margin: EdgeInsets.fromLTRB(22, 25, 22, 25),
                child: Center(
                  child: Text(
                    questions[_currentQuestionIndex].text,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              //CUERPO PREGUNTAS 
                SizedBox(height: 16),
                Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 2.3,
                  children: List.generate(
                    questions[_currentQuestionIndex].options.length,
                    (index) {
                      return ElevatedButton(
                        onPressed: () => _answerQuestion(index),
                        child: Text(
                          questions[_currentQuestionIndex].options[index],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ), textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[300],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 15,
                        ),
                      );
                    },
                  ),
                ),
              ),
              ],
            ):
            
            //VENTANA FINAL 
            Center(
              child: Text(
                '¡HAS TERMINADO EL QUIZ!',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}

class Question {
  final String image;
  final String text;
  final List<String> options;
  final int correctOption;

  Question({
    required this.image,
    required this.text,
    required this.options,
    required this.correctOption,
  });
}

class ResultsPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultsPage({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    String message;
    if (correctAnswers == 0) {
      message = 'tiene ceguera. No lograste percibir los diferentes números y colores correctamente. \nLe sugerimos ir donde un especialista en oftalmología para realizar un diagnóstico más detallado.';
    } else if (correctAnswers == totalQuestions) {
      message = 'no tiene ninguna patología. Su capacidad visual para percibir los colores se encuentra en óptimas condiciones.';
    } else {
      message = 'tiene Discromatopsia Congénita en los colores rojo y verde. Esta patología es el resultado de la alteración en uno o más foto pigmentos de los conos oculares.\nLe sugerimos ir donde un especialista en oftalmología para realizar un diagnóstico más detallado.';
    }
    return Scaffold(

      //APP BAR DIAGNOSTICO
      appBar: AppBar(
        title: Text(
          'RESULTADOS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(243,196,140,30),
      ),

      //CUERPO DIAGNOSTICO
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                ),
              child: Image(
                image: AssetImage('assets/images/diagnostico.png'),
                fit: BoxFit.cover,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(243,196,140,30),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Text(
                'Respuestas correctas: $correctAnswers de $totalQuestions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            SizedBox(height: 20),
            Container(
             margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
              child: Text(
                '¡Tenemos tu diagnostico!',
                style: TextStyle(                
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green[100],
              ),
              padding: EdgeInsets.all(10),
             margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                'Ya analizamos tus respuestas y le informamos que usted  $message',
                style: TextStyle(                
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(height: 0),
              GestureDetector(
                onTap: () {
                Navigator.pop(context);
              },
              child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 70,
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


