import 'dart:convert';
import 'dart:io';

// package path provider
import 'package:app/screens/videos_listing/models/video.dart';
import 'package:path_provider/path_provider.dart';

// modal
import 'package:app/utilities/common/save_json_to_storage/videoModal.dart';

const String fileName = 'videosDownloadInfo.json';
List<Map<String, dynamic>> allJSON = [];
String JSONString = '';

Future<String> get dirPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get jsonFilePath async {
  final path = await dirPath;
  final file = File('$path/$fileName');
  return file;
}

Future<bool> isFileExist() async {
  final data = await jsonFilePath;
  return data.exists();
}

Future<void> writeToFile(List<VideoModal> dataToStore) async {
  if(dataToStore.isNotEmpty) {
    final filePath = await jsonFilePath;

    // converting json to string
    final dataToStoreString = jsonEncode(dataToStore);

    // storing to local storage as a string
    filePath.writeAsString(dataToStoreString);
    print('data added done');
  }
}

Future<List<VideoModal>> readFile() async {
  final filePath = await jsonFilePath;
  final fileExists = await isFileExist();

  if(fileExists) {
    // getting file as string
    final dataReceived = await filePath.readAsString();

    // reading json from the file found
    final dataDecoded = jsonDecode(dataReceived);

    // converting data
    List<VideoModal> mainData = [];
    dataDecoded.forEach((item) {
      mainData.add(
        VideoModal(
          videoId: item['videoId'],
          videoThumbnailUrl: item['videoThumbnailUrl'],
          videoUrl: item['videoPath'],
          videoTitle: item['videoTitle'],
          videoDuration: item['videoDuration'],
          timeStamp: item['timeStamp'],
        )
      );
    });
    return mainData;
  } else {
    return [];
  }
}

// check if id exists in the list
Future<bool> checkIdInList(String id) async {
  bool fileExists = await isFileExist();

  if(fileExists) {
    // getting file as string
    final List<VideoModal> dataList = await readFile();

    final findElement = dataList.where((item) => item.videoId == id);

    if(findElement.length == 1) {
      return true;
    }
    return false;
  }
  return false;
}

Future<String> removeFile() async {
  final filePath = await jsonFilePath;
  filePath.delete();

  return 'file removed successfully';
}