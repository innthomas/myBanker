import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './services/firestore_service.dart';
import 'provider/account_provider.dart';
import './models/account_model.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        StreamProvider(create: (context) => firestoreService.getAccounts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Banker',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
