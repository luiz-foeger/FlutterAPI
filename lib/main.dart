import 'package:flutter/material.dart';
import 'package:flutter_api/post.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter API Example',
      home: PaginaHome(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
        ),
    ),
  }
}

class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}
class _PaginaHomeState extends State<PaginaHome> {
  List<Post?>? post;

  void clickGetButton() {
    developer.log('GET do Banco de Dados clicked!');
    setState(() {
      post = getPostagem();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Flutter API Example'))),
        body: SizedBox(
          height: 500,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<Post?>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      return FormatacaoDados(context, snapshot);
                    } else if (snapshot.hasError) {
                      return Text('Title: ${snapshot.error}');
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              ],
          ),
        ),
      );
  }
}

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Flutter API Example'))),
        body: SizedBox(
          height: 500,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<Post?>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      return FormatacaoDados(context, snapshot);
                    } else if (snapshot.hasError) {
                      return Text('Title: ${snapshot.error}');
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              ],
          ),
        ),
      );
    }

  Future<Post?> getPostagem() async {
    developer.log('Iniciando transação GET!');
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/2');
    final resposta = await(http.get(url));
    
    if (response.statusCode == 200) {
      developer.log('Transação GET finalizada!');
      return Post.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar Post');
    }
  }

  Widget FormatacaoDados(BuildContext context, AsyncSnapshot<Post?> snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(snapshot.data!.title),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(snapshot.data!.description),
        ),
      ],
    )
  }
