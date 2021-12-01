class EvaluationModel {
  String by = '';
  DateTime time = DateTime.now();
  int maxAmount = 0;
  int depreciation = 0;
  String conclusion = '';
  List<String> images = [];

  EvaluationModel({
    required this.by,
    required this.time,
    required this.maxAmount,
    required this.depreciation,
    required this.conclusion,
    required this.images,
  });

  EvaluationModel.init();
}
