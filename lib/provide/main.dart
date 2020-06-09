import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class Counter with ChangeNotifier {
  int _value;

  int get value => _value;

  Counter(this._value);

  void increment() {
    _value++;
    notifyListeners();
  }
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentCounter = Provide.value<Counter>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Provide<Counter>(
                builder: (context, child, counter) => Text('${counter.value}'),
              ),
              StreamBuilder<Counter>(
                  initialData: currentCounter,
                  stream: Provide.stream<Counter>(context)
                      .where((event) => event.value % 2 == 0),
                  builder: (context, snapshot) =>
                      Text('Last even value: ${snapshot.data.value}')
              ),
              FlatButton(
                child: Text('increment'), onPressed: currentCounter.increment,),
              Text('Another widget that does not depend on the Counter'),
            ],
          ),
        )
    );
  }
}

void main() {
  // The class that contains all the providers. This shouldn't change after
  // being used.
  //
  // In this case, the Counter gets instantiated the first time someone uses
  // it, and lives as a singleton after that.
  final providers = Providers()
    ..provide(Provider.function((context) => Counter(0)));

  runApp(ProviderNode(
    providers: providers,
    child: CounterApp(),
  ));
}