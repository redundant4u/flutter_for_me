import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FirstPage extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> deviceList = [];

  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  String _isScanning;
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;

  void initState() {
    super.initState();
    _isScanning = "";
  }

  _addDeviceToList(final BluetoothDevice device) {
    if( !widget.deviceList.contains(device) )
      setState(() { if(this.mounted) widget.deviceList.add(device); });
  }

  ListView _buildView() {
    List<Container> containers = [];
    for( BluetoothDevice device in widget.deviceList ) {
      containers.add(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),

              FlatButton(
                child: Text("Connect"),
                color: Colors.grey,
                onPressed: () async {
                  setState(() { _isScanning = "Connecting..."; });
                  try { await device.connect();  }
                  catch(e) { print(e); }
                  finally {
                    _services = await device.discoverServices();
                    setState(() { _connectedDevice = device; _isScanning = "${device.name} Connect"; });
                  }
                },
              )
            ],
          )
        )
      );
    }

    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Text(_isScanning),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              child: Text('Scan'),
              color: Colors.grey,
              onPressed: () { _isScanning = "Scanning..."; _startScan(); setState(() {}); }
            ),

            MaterialButton(
              child: Text('Check'),
              color: Colors.grey,
              onPressed: () {
                if( _connectedDevice != null ) _isScanning = "${_connectedDevice.name}";
                else _isScanning = "";

                setState(() {});
              }
            ),

            MaterialButton(
              child: Text('Stop'),
              color: Colors.grey,
              onPressed: () { _isScanning = "Stop Scanning"; _stopScan(); setState(() {}); }
            ),
          ],
        ),

        ...containers
      ],
    );
  }

  void _startScan() {
    try {
      widget.flutterBlue.startScan();
      widget.flutterBlue.connectedDevices.asStream().listen((List<BluetoothDevice> devices) {
        for( BluetoothDevice device in devices ) _addDeviceToList(device);
      });
      widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
        for( ScanResult result in results ) _addDeviceToList(result.device);
      });
    }

    catch(e) { print(e); }
  }

  void _stopScan() {
    if( _connectedDevice != null ) {
      _connectedDevice.disconnect(); _connectedDevice = null;
      _services.clear();
    }

    widget.deviceList.clear();
    widget.flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(),
    );
  }
}
