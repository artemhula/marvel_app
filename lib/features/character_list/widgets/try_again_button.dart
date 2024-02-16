
import 'package:flutter/material.dart';

class TryAgainButton extends StatelessWidget {
  TryAgainButton({
    super.key, required this.function,
    
  });

  final Function function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.red),
        foregroundColor:
            MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<
            RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
      child: const Text('Try again'),
    );
  }
}
