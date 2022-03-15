class DetailItemApproveModel {
  String title;
  String value;
  bool? isToken;
  String? urlToken;

  DetailItemApproveModel(
      {required this.title,
      required this.value,
      this.isToken = false,
      this.urlToken});
}
