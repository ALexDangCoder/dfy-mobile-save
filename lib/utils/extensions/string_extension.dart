extension StringHandle on String{
  String handleString() {
    final String result = '${substring(0,10)}...${substring(length - 10)}';
    return result;
  }
}

