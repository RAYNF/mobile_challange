import 'package:flutter/material.dart';
import 'package:mobile_test/provider/palidrome_provider.dart';
import 'package:mobile_test/screen/third_screen.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PalidromeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Second Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome"),
              SizedBox(height: 5),
              Text(
                provider.nameFirstScreen ?? "No Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 222),
              Center(
                child: Text(
                  provider.selectedUserName ?? "Selected User Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ThirdScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey, // sesuai UI contoh
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Choose a User",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
