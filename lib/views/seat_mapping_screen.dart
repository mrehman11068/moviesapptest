import 'package:flutter/material.dart';

class SeatMappingScreen extends StatefulWidget {
  @override
  _SeatMappingScreenState createState() => _SeatMappingScreenState();
}

class _SeatMappingScreenState extends State<SeatMappingScreen> {
  final int frontRows = 3;
  final int frontSeatsPerRow = 8;
  late List<List<bool>> frontSeats;
  final int middleRows = 4;
  final int middleLeftSeatsPerRow = 5;
  final int middleRightSeatsPerRow = 5;
  late List<List<bool>> middleLeftSeats;
  late List<List<bool>> middleRightSeats;
  final int backRows = 2;
  final int backSeatsPerRow = 12;
  late List<List<bool>> backSeats;

  @override
  void initState() {
    super.initState();
    frontSeats = List.generate(frontRows, (_) => List.generate(frontSeatsPerRow, (_) => false));
    middleLeftSeats = List.generate(middleRows, (_) => List.generate(middleLeftSeatsPerRow, (_) => false));
    middleRightSeats = List.generate(middleRows, (_) => List.generate(middleRightSeatsPerRow, (_) => false));
    backSeats = List.generate(backRows, (_) => List.generate(backSeatsPerRow, (_) => false));
  }
  Widget buildSeatTile(String seatLabel, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              isSelected ? 'assets/images/seat_selected.png' : 'assets/images/seat_unselected.png',
              color:
              isSelected ? Colors.green : Colors.grey,
              fit: BoxFit.contain,
            ),
            Text(
              seatLabel,
              style: TextStyle(
                fontSize: 8,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSeatRow(List<bool> seatRow, String rowLabel, {int startSeatNumber = 1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(seatRow.length, (index) {
        String seatLabel = '$rowLabel${index + startSeatNumber}';
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: buildSeatTile(seatLabel, seatRow[index], () {
            setState(() {
              seatRow[index] = !seatRow[index];
            });
          }),
        );
      }),
    );
  }
  Widget buildMiddleRow(String rowLabel, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left block (seats 1 to 4)
        Row(
          children: List.generate(middleLeftSeatsPerRow, (index) {
            String seatLabel = '$rowLabel${index + 1}';
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: buildSeatTile(seatLabel, middleLeftSeats[rowIndex][index], () {
                setState(() {
                  middleLeftSeats[rowIndex][index] = !middleLeftSeats[rowIndex][index];
                });
              }),
            );
          }),
        ),
        // Aisle gap
        SizedBox(width: 10),
        Row(
          children: List.generate(middleRightSeatsPerRow, (index) {
            String seatLabel = '$rowLabel${index + 1 + middleLeftSeatsPerRow}';
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildSeatTile(seatLabel, middleRightSeats[rowIndex][index], () {
                setState(() {
                  middleRightSeats[rowIndex][index] = !middleRightSeats[rowIndex][index];
                });
              }),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> frontRowLabels = ['A', 'B', 'C'];
    List<String> middleRowLabels = ['D', 'E', 'F', 'G'];
    List<String> backRowLabels = ['H', 'I'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Seats'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...List.generate(frontRows, (i) {
              return buildSeatRow(frontSeats[i], frontRowLabels[i]);
            }),
            SizedBox(height: 10), // Gap row
            ...List.generate(middleRows, (i) {
              return buildMiddleRow(middleRowLabels[i], i);
            }),
            SizedBox(height: 10), // Gap row
            ...List.generate(backRows, (i) {
              return buildSeatRow(backSeats[i], backRowLabels[i]);
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seats booked successfully!')),
                );
              },
              child: Text('Book Seats'),
            ),
          ],
        ),
      ),
    );
  }
}
