import 'package:firebase_authentication/OtherUserProfile/OtherBloc/bloc/otheruser_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/bloc/post_bloc.dart';
import 'package:firebase_authentication/UserPage/All%20Post/bloc/private_bloc.dart';
import 'package:firebase_authentication/UserPage/getpostlength/bloc/getpost_bloc.dart';
import 'package:firebase_authentication/UserPage/getpostlength/getpostpublic/bloc/get_post_public_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostBloc()..add(Postfetchevent())),
        BlocProvider(create: (context) => PrivateBloc()..add(PostLoadingPrivate())),
        BlocProvider(create: (context) => OtheruserBloc()..add(OhterUserLoadingEvent())),
        BlocProvider(create: (context) => GetpostBloc()..add(GetPostLoadingEvent())),
        BlocProvider(create: (context) => GetPostPublicBloc()..add(GetPostPublicLoadingEvent())),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          navigatorKey: navigatorkey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
            fontFamily: "Georgia",
          ),
          // home: const Intro(),
          initialRoute: "/",
          onGenerateRoute: router.generateRoute,
        ),
      ),
    );
  }
}
