import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  LoadingWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          if (message != null) ...[
            SizedBox(height: 10),
            Text(message!),
          ]
        ],
      ),
    );
  }
}
