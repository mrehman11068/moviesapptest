import 'package:flutter/material.dart';

class SeatMappingScreen extends StatefulWidget {
  @override
  _SeatMappingScreenState createState() => _SeatMappingScreenState();
}

class _SeatMappingScreenState extends State<SeatMappingScreen> {
  // Create a 5x5 grid representing seats
  List<List<bool>> seats =
  List.generate(5, (_) => List.generate(5, (_) => false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Seats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 25,
                itemBuilder: (context, index) {
                  int row = index ~/ 5;
                  int col = index % 5;
                  bool isSelected = seats[row][col];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        seats[row][col] = !isSelected;
                      });
                    },
                    child: Container(
                      color: isSelected ? Colors.green : Colors.grey,
                      child: Center(
                        child: Text('${row * 5 + col + 1}'),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle booking; here we simply show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seats booked successfully!')),
                );
              },
              child: Text('Book Seats'),
            )
          ],
        ),
      ),
    );
  }
}
