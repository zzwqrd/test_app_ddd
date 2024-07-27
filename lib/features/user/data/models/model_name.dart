import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  ProductModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  final List<ProductDatum> data;
  final Links? links;
  final Meta? meta;
  final String status;
  final String message;

  ProductModel copyWith({
    List<ProductDatum>? data,
    Links? links,
    Meta? meta,
    String? status,
    String? message,
  }) {
    return ProductModel(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      data: json["data"] == null
          ? []
          : List<ProductDatum>.from(
              json["data"]!.map((x) => ProductDatum.fromJson(x))),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      status: json["status"] ?? "",
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
        "status": status,
        "message": message,
      };

  @override
  List<Object?> get props => [
        data,
        links,
        meta,
        status,
        message,
      ];
}

class ProductDatum extends Equatable {
  ProductDatum({
    required this.id,
    required this.name,
    required this.description,
    required this.media,
  });

  final int id;
  final String name;
  final String description;
  final String media;

  ProductDatum copyWith({
    int? id,
    String? name,
    String? description,
    String? media,
  }) {
    return ProductDatum(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      media: media ?? this.media,
    );
  }

  factory ProductDatum.fromJson(Map<String, dynamic> json) {
    return ProductDatum(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      media: json["media"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "media": media,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        media,
      ];
  static List<ProductDatum> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductDatum.fromJson(json)).toList();
  }
}

class Links extends Equatable {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  final String first;
  final String last;
  final dynamic prev;
  final dynamic next;

  Links copyWith({
    String? first,
    String? last,
    dynamic? prev,
    dynamic? next,
  }) {
    return Links(
      first: first ?? this.first,
      last: last ?? this.last,
      prev: prev ?? this.prev,
      next: next ?? this.next,
    );
  }

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json["first"] ?? "",
      last: json["last"] ?? "",
      prev: json["prev"],
      next: json["next"],
    );
  }

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };

  @override
  List<Object?> get props => [
        first,
        last,
        prev,
        next,
      ];
}

class Meta extends Equatable {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final int from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    return Meta(
      currentPage: currentPage ?? this.currentPage,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      links: links ?? this.links,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"] ?? 0,
      from: json["from"] ?? 0,
      lastPage: json["last_page"] ?? 0,
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      path: json["path"] ?? "",
      perPage: json["per_page"] ?? 0,
      to: json["to"] ?? 0,
      total: json["total"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links.map((x) => x?.toJson()).toList(),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };

  @override
  List<Object?> get props => [
        currentPage,
        from,
        lastPage,
        links,
        path,
        perPage,
        to,
        total,
      ];
}

class Link extends Equatable {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String url;
  final String label;
  final bool active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"] ?? "",
      label: json["label"] ?? "",
      active: json["active"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };

  @override
  List<Object?> get props => [
        url,
        label,
        active,
      ];
}
