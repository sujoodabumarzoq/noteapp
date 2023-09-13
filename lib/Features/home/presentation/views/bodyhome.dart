import 'package:flutter/material.dart';

class bodyhome extends StatelessWidget {
  const bodyhome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 160),
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset("images/folder.png", height: 100, width: 100),
                const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(10),

            child: Column(
              children: [
                Image.asset("images/folder.png", height: 100, width: 100),
                const Text(
                  "unvirsty",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
