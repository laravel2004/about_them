import 'package:flutter/material.dart';


class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const  Column(
      children: [
        Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0 * 2),
        Row(
          children: [
            Spacer(),
          ],
        ),
        SizedBox(height: 16.0 * 2),
      ],
    );
  }
}
