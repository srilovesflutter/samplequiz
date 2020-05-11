import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            'Welcome to Quiz App',
            style: TextStyle(fontSize: 30.0),
          )),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: FlutterLogo(size: 200.0),
          ),
          Center(
              child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizPlayPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.play_arrow,
                size: 40.0,
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class QuizPlayPage extends StatefulWidget {
  @override
  _QuizPlayPageState createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  int questionindex = 0;
  TextStyle _questionstyle = TextStyle(fontSize: 25.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Quiz Title')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Enjoy playing the Quiz',
                style: _questionstyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  LinearProgressIndicator(value: calculatevalue(questionindex)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                questions[questionindex].title,
                style: _questionstyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopulateOptions(index: questionindex),
            ),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    if (questionindex < questions.length - 1) {
                      nextclicked = true;

                      questionindex++;
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizEndPage()));
                    }
                  });
                },
                child: Text('Next'))
          ],
        ));
  }
}

class PopulateOptions extends StatefulWidget {
  final int index;

  const PopulateOptions({Key key, this.index}) : super(key: key);

  @override
  _PopulateOptionsState createState() => _PopulateOptionsState();
}

bool nextclicked = false;

class _PopulateOptionsState extends State<PopulateOptions> {
  Widget _trailing;
  int selectedoption = -1;

  @override
  void initState() {
    print('123');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String answer =
        questions[widget.index].options[questions[widget.index].answer - 1];

    return Column(
        children: List.generate(
            questions[widget.index].options.length,
            (i) => ListTile(
                  onTap: () {
                    print(nextclicked);
                    setState(() {
                      _trailing =
                          validate(questions[widget.index].options[i], answer);
                      selectedoption = i;
                      nextclicked = false;
                    });
                  },
                  title: Text(questions[widget.index].options[i]),
                  trailing: (selectedoption == i && nextclicked == false)
                      ? _trailing
                      : (selectedoption == i &&
                              selectedoption != -1 &&
                              nextclicked == false)
                          ? _trailing
                          : null,
                )));
  }
}

Widget validate(String option, String answer) {
  return option == answer ? Icon(Icons.check) : Icon(Icons.close);
}

double calculatevalue(int questionindex) {
  return questionindex / questions.length;
}

class Question {
  final String title;
  final List<String> options;
  final int answer;

  Question({this.title, this.options, this.answer});
}

List<Question> questions = [
  Question(
      title: 'Capital City of country Saudi Arabia?',
      options: ['Medina', 'Mecca', 'Riyadh', 'Jeddah'],
      answer: 3),
  Question(
      title: 'Capital City of country Singapore?',
      options: ['Tampines', 'Hougang', 'Pasir Ris', 'Singapore'],
      answer: 4),
  Question(
      title: 'Capital City of country South Korea',
      options: ['Incheon', 'Daegu', 'Busan', 'Seoul'],
      answer: 4),
  Question(
      title: 'Capital City of country Spain',
      options: ['Barcelona', 'Seville', 'Valencia', 'Madrid'],
      answer: 4),
];

class QuizEndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Text(
              'Well done, you have finished the Quiz',
              style: TextStyle(fontSize: 30.0),
            )),
          ),
          Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Play again', style: TextStyle(fontSize: 20.0)),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizPlayPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.play_arrow,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
