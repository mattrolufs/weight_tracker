import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/presentation/view_models/auth_screen_view_model.dart';
import 'package:weight_tracker/presentation/views/weight_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: ref.watch(authScreenViewModelProvider).onAuthStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(title: const Text("Sign In Screen")),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          ref.read(authScreenViewModelProvider).signIn();
                        },
                        child: const Text("Sign In")),
                  ),
                ],
              ));
        } else {
          return const WeightScreen();
        }
      },
    );
  }
}
