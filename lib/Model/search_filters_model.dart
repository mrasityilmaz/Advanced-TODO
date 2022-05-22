class SearchItemModel {
  int index;
  String name;
  bool selected;

  SearchItemModel(
      {required this.index, required this.name, required this.selected});
}

List<SearchItemModel> searchTagInitialData = [
  SearchItemModel(index: 0, name: "Titles", selected: true),
  SearchItemModel(index: 1, name: "Descriptions", selected: true),
  SearchItemModel(index: 2, name: "Tags", selected: true),
  SearchItemModel(index: 3, name: "Missions", selected: true),
  SearchItemModel(index: 4, name: "Group", selected: true),
  SearchItemModel(index: 5, name: "No Group", selected: true)
];
