import 'package:syberwaifu/enums/image_source.dart';

ImageSource? getSource(String url) {
  if (url.startsWith('assets://')) {
    return ImageSource.assets;
  } else if (url.startsWith('https://') || url.startsWith('http://')) {
    return ImageSource.network;
  } else if (url.startsWith('file://')) {
    return ImageSource.file;
  }
  return null;
}

bool isAssets(String url) {
  return getSource(url) == ImageSource.assets;
}

bool isFile(String url) {
  return getSource(url) == ImageSource.file;
}

bool isNetwork(String url) {
  return getSource(url) == ImageSource.network;
}

String getUri(String url) {
  final source = getSource(url);
  if (source == ImageSource.assets) {
    return url.substring('assets://'.length);
  } else if (source == ImageSource.file) {
    return url.substring('file://'.length);
  } else {
    return url;
  }
}
