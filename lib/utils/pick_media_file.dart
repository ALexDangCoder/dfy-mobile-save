
import 'package:file_picker/file_picker.dart';

Future<Map<String, dynamic>> pickMediaFile() async {
  String filePath = '';
  String mediaType = '';
  int fileSize = 0;
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'mp4',
      'WEBM',
      'mp3',
      'WAV',
      'OGG',
      'png',
      'jpg',
      'jpeg',
      'GIF'
    ],
  );
  if (result != null) {
    final fileExtension = result.files.single.extension;
    if (fileExtension == 'mp4' || fileExtension == 'webm') {
      mediaType = 'video';
    } else if (fileExtension == 'mp3' ||
        fileExtension == 'wav' ||
        fileExtension == 'OOG') {
      mediaType = 'audio';
    } else {
      mediaType = 'image';
    }
    filePath = result.files.single.path ?? '';
    fileSize = result.files.single.size;
  } else {
    // User canceled the picker
  }
  return {'type': mediaType, 'path': filePath,'size' : fileSize};
}
