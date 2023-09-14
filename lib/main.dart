import 'package:amazon_shop/data/services/auth_service.dart';
import 'package:amazon_shop/features/admin/screens/admin_screen.dart';
import 'package:amazon_shop/features/auth/screens/auth_screen.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:amazon_shop/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants/global_variables.dart';
import 'common/widgets/bottom_bar.dart';

void main() {
  //error doesnot include provider, solusinya bungkus myapp
  //pakai multi provider
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon Clone",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //primarySwatch: Colors.blue
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          //warna dasar aplikasi
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
              //color: ,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ))),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();

    //dpaatin data user ketika pertama kali diload
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Center",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // builder dipakai kalau ada data dinamis
            Builder(builder: (context) {
              return ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.blueGrey,
                // ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AuthScreen.routeName,
                  );
                },
                child: const Text("Klik"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
