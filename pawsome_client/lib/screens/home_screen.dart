import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // checkAuth();
    Provider.of<AuthProvider>(context, listen: false).getAuthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return auth.user['email'] != null
                    ? Text('Welcome ${auth.user['email']}')
                    : const CircularProgressIndicator()
                ;
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                context.go('/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
