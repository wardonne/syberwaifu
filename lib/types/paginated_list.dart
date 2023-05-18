class PaginatedList<T> extends Object {
  final int total;
  final List<T> items;

  PaginatedList({required this.total, required this.items});
}
