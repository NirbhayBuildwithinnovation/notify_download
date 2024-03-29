import 'dart:isolate';
import 'dart:ui';
import 'package:notify_download/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProvider with ChangeNotifier {
  int downloadProgress = 0;
  ReceivePort receivePort = ReceivePort();

Future<void> createEnqueue() async {
  FlutterDownloader.registerCallback(callback);

  final appDocDir = await getApplicationDocumentsDirectory();

  await FlutterDownloader.enqueue(
    url: imageUrl, 
    savedDir: appDocDir.path, 
    saveInPublicStorage: true
  );
}

  @pragma('vm:entry-point')
  static void callback(String id, int status, int progress) {
    debugPrint(
        'Download task ($id) is in status ($status) and process ($progress)'
    );
    final SendPort? sPort = IsolateNameServer.lookupPortByName(portName);
    sPort?.send([id, status, progress]);
  }

  Future<void> registerIsolate() async {
    bool success =
        IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);
    /*if(!success) {
    registerIsolate();
    _dispose();
    }*/
    receivePort.listen((dynamic data) {
      debugPrint('Data: $data');
      downloadProgress = _getProgress(data[1], data[2]);
    });
    //_dispose();
  }

  int _getProgress(int status, int progress) {
    switch (status) {
      case 0:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 1:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 2:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 3:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 4:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 5:
        downloadProgress = progress;
        notifyListeners();
        break;
      case 6:
        downloadProgress = progress;
        notifyListeners();
        break;
      default:
        downloadProgress;
    }
    return downloadProgress;
  }

  void _dispose() {
    IsolateNameServer.removePortNameMapping(portName);
  }

  void reset() {
    downloadProgress = 0;
    notifyListeners();
  }
}
