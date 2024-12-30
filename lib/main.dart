import 'package:design_notes/authentication/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()  async{

  await Supabase.initialize(
      url: "https://rhumlrbsesrddbskxlfp.supabase.co",

      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJodW1scmJzZXNyZGRic2t4bGZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQzNDU1MzksImV4cCI6MjA0OTkyMTUzOX0.jSBvEl6H2gDZ6FgPTz6HbFvrR-pAQkoPKM67uFsffcI");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInScreen(),
        builder: EasyLoading.init(),
    );
  }
}

