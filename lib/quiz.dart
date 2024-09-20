import 'package:flutter/material.dart';
import 'package:quiz_app_1/data/questions.dart';
import 'package:quiz_app_1/questions_screen.dart';
import 'package:quiz_app_1/start_screen.dart';
import 'package:quiz_app_1/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';
  var currentQuestionIndex = 0;

  void switchScreen() {
    setState(() {
      // If they have already started the quiz, resume from the current question
      if (selectedAnswers.isNotEmpty) {
        activeScreen =
            'question-screen'; // Resume the quiz from where they left off
      } else {
        activeScreen =
            'question-screen'; // If they haven't started, start a new quiz
      }
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (currentQuestionIndex + 1 >= questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  // Go back to the previous question (if not on the first question)
  void goBack() {
    if (currentQuestionIndex > 0) {
      setState(() {
        selectedAnswers.removeLast(); // Remove the last selected answer
        currentQuestionIndex--; // Move back to the previous question
      });
    }
  }

  void goToMainMenu() {
    setState(() {
      activeScreen =
          'start-screen'; // Only switch the screen to the start screen
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
      currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
        onGoBack: goBack, // Provide the back functionality
        canGoBack:
            currentQuestionIndex > 0, // Enable back button after first question
        currentQuestionIndex:
            currentQuestionIndex, // Pass the current question index
        onGoToMainMenu: goToMainMenu,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 104, 58, 183),
              Color.fromARGB(255, 88, 23, 202)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
