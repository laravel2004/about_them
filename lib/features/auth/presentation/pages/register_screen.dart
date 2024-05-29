import 'package:flutter/material.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        const Row(
          children: [
            Spacer(),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
