class GetRepoUrl {
  final String date;
  final String itemCount;
  final String page;
  GetRepoUrl({required this.itemCount, required this.date, required this.page});
  String get getRepoUrl {
    return "https://api.github.com/search/repositories?q=created:>$date&sort=stars&order=desc&page=$page&per_page=$itemCount";
  }
}
