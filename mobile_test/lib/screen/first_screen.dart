import 'package:flutter/material.dart';
import 'package:mobile_test/provider/palidrome_provider.dart';
import 'package:mobile_test/screen/second_screen.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final nameController = TextEditingController();

  final sentenceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    sentenceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PalidromeProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     "Palindrome App",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 20),
                // Text(
                //   "Selamat datang 👋",
                //   style: TextStyle(
                //     fontSize: 28,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.blue[800],
                //   ),
                // ),
                // const SizedBox(height: 8),
                // const Text(
                //   "Masukkan nama dan kalimat untuk memeriksa apakah palindrom",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 15, color: Colors.black54),
                // ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white60,
                  child: Icon(Icons.person, size: 20, color: Colors.white),
                ),
                SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          // labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hint: Text(
                            "Name",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Masukkan nama!" : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: sentenceController,
                        decoration: InputDecoration(
                          hint: Text(
                            "Sentence",
                            style: TextStyle(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Masukkan kalimat!" : null,
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 41,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2B637B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),

                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              provider.check(sentenceController.text.trim());

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  final isPalindrome =
                                      provider.resultMessage == "isPalidrome";

                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isPalindrome
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            size: 70,
                                            color: isPalindrome
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(height: 15),

                                          Text(
                                            provider.resultMessage ?? "",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: isPalindrome
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isPalindrome
                                                  ? Colors.green
                                                  : Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 12,
                                              ),
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Check",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 41,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2B637B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              provider.setNameFirstScreen(
                                nameController.text.trim(),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SecondScreen();
                                  },
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
