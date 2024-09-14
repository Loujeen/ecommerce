class CategoryOrBrandResponseEntity {
  CategoryOrBrandResponseEntity({
    this.results,
    this.metadata,
    this.data,
  });

  int? results;
  Metadata? metadata;
  List<CategoryOrBrandEntity>? data;
}

class CategoryOrBrandEntity {
  CategoryOrBrandEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  String? id;
  String? name;
  String? slug;
  String? image;
}

class Metadata {
  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  int? currentPage;
  int? numberOfPages;
  int? limit;
}