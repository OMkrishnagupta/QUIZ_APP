import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
   
   {
      'question': 'Which one of the following is the hottest planet?',
      'options': ['Mercury', 'Mars', 'venus', 'Saturn'],
      'correctIndex': 2,
    },
    {
      'question': 'Largest continent in the World?',
      'options': ['Asia', 'Europe', 'Africa', 'Australia'],
      'correctIndex': 0,
    },
    {
      'question': 'Which team won Cricket World 2023?',
      'options': ['India', 'Netherland', 'Australia', 'South africa'],
      'correctIndex': 2,
    },
    {
      'question': 'Who wrote "Harry Potter"?',
      'options': ['Charles Dickens', 'JK Rowlings', 'William Shakespeare', 'Mark Twain'],
      'correctIndex': 1,
    },
    {
      'question': 'Who is the current president of India?',
      'options': ['Amit Shah', 'Nitin Gadkari', 'Naredra Modi', 'Droupadi Murmu'],
      'correctIndex': 3,
    },
    {
      'question': 'Number of Union Teritory in India?',
      'options': ['Five', 'Seven', 'Nine', 'Eight'],
      'correctIndex': 3,
    },
    {
      'question': 'Which is the largest planet?',
      'options': ['Mars', 'Jupiter', 'Earth', 'Venus'],
      'correctIndex': 1,
    },
    {
      'question': 'Who discovered Zero?',
      'options': ['Aryabhatta', 'Albert Einstein', 'Galileo Galilei', 'Stephen Hawking'],
      'correctIndex': 0,
    },
    // Add more questions...
  ];

  void _checkAnswer(int selectedIndex) {
  if (_currentIndex < questions.length - 1 && !_submitted) {
    if (selectedIndex == questions[_currentIndex]['correctIndex']) {
      setState(() {
        _score++;
      });
    }
  }
}

  void _nextQuestion() {
  setState(() {
    if (_currentIndex < questions.length - 1 && !_submitted) {
      _currentIndex++;
    }
  });
}

  void _previousQuestion() {
  setState(() {
    if (_currentIndex > 0 && !_submitted) {
      _currentIndex--;
    }
  });
}

  void _submitQuiz() {
    setState(() {
      _submitted = true;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text('Your Score: $_score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Continue', style: TextStyle(color: Color.fromARGB(255, 245, 182, 7))),
          ),
          TextButton(
            onPressed: () {
              _restartQuiz(); // Call _restartQuiz when Restart Quiz is pressed
              Navigator.pop(context);
            },
            child: Text('Restart Quiz', style: TextStyle(color: Color.fromARGB(255, 244, 205, 10))),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Color.fromARGB(255, 236, 175, 8),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 211, 5, 139),
              ),
              child: Text(
                'Quiz App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more drawer items...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 242, 182, 4),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Color.fromARGB(255, 232, 202, 4),
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 236, 197, 5),
                    ),
                    child:
                        Text('Previous', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 215, 180, 3),
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 224, 191, 5),
                  ),
                  child: Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 203, 163, 4),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Color.fromARGB(255, 189, 149, 3),
      ),
    );
  }
}