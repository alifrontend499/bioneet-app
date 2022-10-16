import 'dart:convert';
import 'dart:io';

// package path provider
import 'package:path_provider/path_provider.dart';

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

void writeToFile(List<Map<String, dynamic>> data) async {
  // creating json data
  final List<Map<String, dynamic>> newJSON = data;

  // adding data to all json
  allJSON.addAll(newJSON);

  // converting json to string
  JSONString = jsonEncode(allJSON);

  // storing to local storage as a string
  final filePath = await jsonFilePath;
  filePath.writeAsString(JSONString);
}

Future<List<Map<String, dynamic>>> readFile() async {
  final filePath = await jsonFilePath;
  final fileExists = await isFileExist();

  if(fileExists) {
    // getting file as string
    JSONString = await filePath.readAsString();

    // reading json from the file found
    allJSON = [jsonDecode(JSONString)];
    return allJSON;
  } else {
    return [];
  }
}

Future<String> removeFile() async {
  final filePath = await jsonFilePath;
  filePath.delete();

  return 'file removed successfully';
}