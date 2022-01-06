class DetailItemApproveModel {
  String title;
  String value;
  bool? isToken;

  DetailItemApproveModel(
      {required this.title, required this.value, this.isToken = false});
}