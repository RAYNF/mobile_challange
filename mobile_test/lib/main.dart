import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_test/provider/api_provider.dart';
import 'package:mobile_test/provider/palidrome_provider.dart';
import 'package:mobile_test/screen/first_screen.dart';
import 'package:mobile_test/service/api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiProvider(ApiService(Client())),
        ),
        ChangeNotifierProvider(create: (_) => PalidromeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: FirstScreen(),
      ),
    );
  }
}
