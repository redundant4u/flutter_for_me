import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindBluetoothPage extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> deviceList = [];

  @override
  FindBluetoothPageState createState() => new FindBluetoothPageState();
}

class FindBluetoothPageState extends State<FindBluetoothPage> {
  String _isScanning = "";
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;

  @override
  void dispose() {
    super.dispose();
    _stopScan();
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
              onPressed: () { Navigator.pop(context, true); }
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
    widget.flutterBlue?.stopScan(); // 'Another scan is already in progress' exception 방지
    widget.flutterBlue?.startScan();

    widget.flutterBlue.connectedDevices.asStream().listen((List<BluetoothDevice> devices) {
      for( BluetoothDevice device in devices ) _addDeviceToList(device);
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for( ScanResult result in results ) _addDeviceToList(result.device);
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('주변 기기 찾기', style: TextStyle(color: Colors.black))
      ),
      body: _buildView(),
    );
  }
}
