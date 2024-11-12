String shortenFileName(String fileName) {
  const int maxLength = 20;
  if (fileName.length <= maxLength) {
    return fileName;
  }
  return '${fileName.substring(0, maxLength ~/ 2)}...${fileName.substring(fileName.length - maxLength ~/ 2)}';
}
