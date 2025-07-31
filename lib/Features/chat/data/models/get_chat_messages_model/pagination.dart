class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  dynamic nextPageUrl;
  dynamic previousPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json['total'] as int?,
    perPage: json['perPage'] as int?,
    currentPage: json['currentPage'] as int?,
    lastPage: json['lastPage'] as int?,
    firstPage: json['firstPage'] as int?,
    firstPageUrl: json['firstPageUrl'] as String?,
    lastPageUrl: json['lastPageUrl'] as String?,
    nextPageUrl: json['nextPageUrl'] as dynamic,
    previousPageUrl: json['previousPageUrl'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'perPage': perPage,
    'currentPage': currentPage,
    'lastPage': lastPage,
    'firstPage': firstPage,
    'firstPageUrl': firstPageUrl,
    'lastPageUrl': lastPageUrl,
    'nextPageUrl': nextPageUrl,
    'previousPageUrl': previousPageUrl,
  };
}
