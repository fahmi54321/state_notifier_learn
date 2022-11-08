import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_learn/provider/bg_color.dart';
import 'package:state_notifier_learn/provider/counter.dart';
import 'package:state_notifier_learn/provider/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(
          create: (context) => BgColor(),
        ),
        StateNotifierProvider<Counter, CounterState>(
          create: (context) => Counter(),
        ),
        StateNotifierProvider<CustomerLevel, Level>(
          create: (context) => CustomerLevel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();

    return Scaffold(
      backgroundColor: levelState == Level.bronze
          ? Colors.white
          : levelState == Level.silver
              ? Colors.grey
              : Colors.yellow,
      appBar: AppBar(
        backgroundColor: colorState.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<Counter>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              context.read<BgColor>().changeColor();
            },
            tooltip: 'Change color',
            child: const Icon(Icons.color_lens_outlined),
          ),
        ],
      ),
    );
  }
}
