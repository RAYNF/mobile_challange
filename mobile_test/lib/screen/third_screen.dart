import 'package:flutter/material.dart';
import 'package:mobile_test/model/api_state.dart';
import 'package:mobile_test/provider/api_provider.dart';
import 'package:mobile_test/provider/palidrome_provider.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final apiProvider = context.read<ApiProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (apiProvider.pageItems != null) {
          apiProvider.getUsers();
        }
      }
    });

    Future.microtask(() async => apiProvider.getUsers());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Third Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<ApiProvider>(
        builder: (context, value, child) {
          final state = value.userState;
          if (state == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state == ApiState.loaded) {
            final qoutes = value.qoutes;
            return ListView.builder(
              controller: scrollController,
              itemCount: qoutes.length + (value.pageItems != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == qoutes.length && value.pageItems != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final qoute = qoutes[index];
                return GestureDetector(
                  onTap: () {
                    context.read<PalidromeProvider>().setSelectedUser(
                      "${qoute.firstName} ${qoute.lastName}",
                    );

                    Navigator.pop(context);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipOval(
                              child: Image.network(
                                qoute.avatar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                qoute.firstName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              Text(qoute.email),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
