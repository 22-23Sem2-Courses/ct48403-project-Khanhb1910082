import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/service/favorite_service.dart';
import 'package:myproject_app/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';

import 'ui/screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => FavoriteManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turtle-K Shop',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginView()
            : const HomeView(0),
      ),
    );
  }
}

// class MainPage extends StatelessWidget {
//   const MainPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white70,
//         body: StreamBuilder<List<Users>>(
//             stream: UserService.readUser(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const LoginView();
//               } else {
//                 return const HomeView(
//                   0,
//                 );
//               }
//             }));
//   }
// }
