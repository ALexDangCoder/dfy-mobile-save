class ItemMenuModel {
  String icon;
  String routeName;
  String title;
  List<ItemMenuModel> children;

  ItemMenuModel(
      {required this.icon,
      required this.routeName,
      required this.title,
      required this.children});

  factory ItemMenuModel.createChild({
    required String routeName,
    required String title,
  }) {
    return ItemMenuModel(
      routeName: routeName,
      title: title,
      icon: '',
      children: [],
    );
  }

  factory ItemMenuModel.createParent({
    required String routeName,
    required String title,
    required String icon,
    required List<ItemMenuModel> children,
  }) {
    return ItemMenuModel(
      routeName: routeName,
      title: title,
      icon: icon,
      children: children,
    );
  }
}
