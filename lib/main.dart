import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      title: 'Smart Home',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _gateCurrent = false;
  var _doorCurrent = false;
  var _roomCurrent = false;
  var _kitchenCurrent = false;
  var _tvCurrent = false;
  var _acTemp = 27.0;

  var _gateTitle = 'Gate';
  var _doorTitle = 'Front Door';
  var _roomTitle = 'Room Light';
  var _kitchenTitle = 'Kitchen Light';
  var _tvTitle = 'TV Remote Control';
  var _acTitle = 'Air Conditioner';

  Widget _homeKey(String category, bool currentState) {
    Widget keyWidget = Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(category,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: currentState ? Colors.blue : Colors.grey),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: currentState ? Colors.blue : Colors.grey,
                  ),
                  splashColor: Colors.grey,
                  tooltip: 'Press to lock/unlock',
                  onPressed: () {
                    setState(() {
                      if (category == _gateTitle) {
                        _gateCurrent = !_gateCurrent;
                      } else if (category == _doorTitle) {
                        _doorCurrent = !_doorCurrent;
                      } else {
                        _gateCurrent = _gateCurrent;
                        _doorCurrent = _doorCurrent;
                      }
                    });
                  }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: currentState
                  ? Icon(
                      Icons.lock_open,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
            ),
            Text(currentState ? 'UNLOCKED' : 'LOCKED'),
          ],
        ),
      ),
    );
    return keyWidget;
  }

  Widget _lighting(String category, bool currentState) {
    Widget lightingWidget = Card(
      elevation: 10,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(category,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: currentState ? Colors.blue : Colors.grey),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: currentState ? Colors.blue : Colors.grey,
                  ),
                  splashColor: Colors.grey,
                  tooltip: 'Press to turn on/off the light',
                  onPressed: () {
                    setState(() {
                      if (category == _roomTitle) {
                        _roomCurrent = !_roomCurrent;
                      } else if (category == _kitchenTitle) {
                        _kitchenCurrent = !_kitchenCurrent;
                      } else {
                        _roomCurrent = _roomCurrent;
                        _kitchenCurrent = _kitchenCurrent;
                      }
                    });
                  }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: currentState
                  ? Icon(
                      Icons.lightbulb,
                      color: Colors.amber,
                    )
                  : Icon(
                      Icons.lightbulb,
                      color: Colors.grey,
                    ),
            ),
            Text(currentState ? 'LIGHT ON' : 'LIGHT OFF'),
          ],
        ),
      ),
    );
    return lightingWidget;
  }

  Widget _tvRemote() {
    Widget remoteWidget = Card(
      elevation: 10,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_tvTitle,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            IconButton(
              splashColor: Colors.grey,
              icon: _tvCurrent ? Icon(Icons.toggle_on) : Icon(Icons.toggle_off),
              tooltip: 'Press to turn on/off the television',
              color: _tvCurrent ? Colors.blue : Colors.grey,
              onPressed: () => setState(() => _tvCurrent = !_tvCurrent),
            ),
            Text(_tvCurrent ? 'TV ON' : 'TV OFF'),
          ],
        ),
      ),
    );
    return remoteWidget;
  }

  Widget _acRemote() {
    Widget acWidget = Card(
      elevation: 10,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_acTitle,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            IconButton(
                splashColor: Colors.grey,
                icon: Icon(Icons.arrow_circle_up),
                tooltip: 'Increase temperature',
                color: _acTemp < 30.0 ? Colors.blue : Colors.grey,
                onPressed: () {
                  setState(() {
                    _acTemp < 30.0 ? _acTemp += 1.0 : _acTemp = _acTemp;
                  });
                }),
            IconButton(
                splashColor: Colors.grey,
                icon: Icon(Icons.arrow_circle_down),
                tooltip: 'Decrease temperature',
                color: _acTemp > 16.0 ? Colors.blue : Colors.grey,
                onPressed: () {
                  setState(() {
                    _acTemp > 16.0 ? _acTemp -= 1.0 : _acTemp = _acTemp;
                  });
                }),
            Text('Temperature: $_acTemp Celcius')
          ],
        ),
      ),
    );
    return acWidget;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Smart Home'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Key'),
                Tab(text: 'Lighting'),
                Tab(text: 'Devices'),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: <Widget>[
                      _homeKey(_gateTitle, _gateCurrent),
                      _homeKey(_doorTitle, _doorCurrent),
                      _lighting(_roomTitle, _roomCurrent),
                      _lighting(_kitchenTitle, _kitchenCurrent),
                      _tvRemote(),
                      _acRemote(),
                    ])),
            Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: <Widget>[
                      _homeKey(_gateTitle, _gateCurrent),
                      _homeKey(_doorTitle, _doorCurrent),
                    ])),
            Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: <Widget>[
                      _lighting(_roomTitle, _roomCurrent),
                      _lighting(_kitchenTitle, _kitchenCurrent),
                    ])),
            Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: <Widget>[
                      _tvRemote(),
                      _acRemote(),
                    ])),
          ])),
    );
  }
}
