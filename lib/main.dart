import 'package:flutter/material.dart';
import 'package:karyawan_list/main_page.dart';
import 'package:karyawan_list/provider/karyawan_provider.dart';
import 'package:karyawan_list/widget/add_karyawan.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => KaryawanProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Fetch API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: 'Karyawan List',
        ),
        // routes: {
        //   AddKaryawan.routeName :(context) => AddKaryawan(),
        // },
      ),
    );
  }
}
