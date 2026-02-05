class BytesToOtherConversion {
  static String convertBytesToReadableFormat(int bytes) {
    if (bytes < 1024) {
      return "$bytes B";
    } else if (bytes < 1048576) {
      double kb = bytes / 1024;
      return "${kb.toStringAsFixed(2)} KB";
    } else if (bytes < 1073741824) {
      double mb = bytes / 1048576;
      return "${mb.toStringAsFixed(2)} MB";
    } else {
      double gb = bytes / 1073741824;
      return "${gb.toStringAsFixed(2)} GB";
    }
  }
}
