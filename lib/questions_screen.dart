import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_1/answer_button.dart';
import 'package:quiz_app_1/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
    required this.onGoBack,
    required this.canGoBack,
    required this.currentQuestionIndex, // Accept the currentQuestionIndex from the parent
  });

  final void Function(String answer) onSelectAnswer;
  final void Function() onGoBack; // Callback for going back
  final bool
      canGoBack; // Whether the user can go back (only true after the first question)
  final int currentQuestionIndex; // The current question index

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[widget.currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 232, 231, 255),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  widget.onSelectAnswer(answer);
                },
              );
            }).toList(),
            const SizedBox(height: 20),
            // Add a back button with conditional disabling based on whether going back is allowed.
            ElevatedButton(
              onPressed: widget.canGoBack
                  ? widget.onGoBack
                  : null, // Disable if not allowed to go back
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.canGoBack
                    ? Colors.blue
                    : Colors.grey, // Gray out button when disabled
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
