class DioceseModel {
  String? terminus;
  String? status;
  DioceseResponse? dioceseResponse;

  DioceseModel({this.terminus, this.status, this.dioceseResponse});

  DioceseModel.fromJson(Map<String, dynamic> json) {
    terminus = json['terminus'];
    status = json['status'];
    dioceseResponse = json['response'];
  }
}

class DioceseResponse {
  int? code;
  String? title;
  String? message;
  DioceseData? data;

  DioceseResponse({this.code, this.title, this.message, this.data});

  DioceseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    message = json['message'];
    if (json['data'] != null) {
      data = DioceseData.fromJson(json['data']);
    }
  }
}

class DioceseData {
  PaginationMeta? paginationMeta;
  List<DataItems>? dataItems;

  DioceseData({this.paginationMeta, this.dataItems});

  DioceseData.fromJson(Map<String, dynamic> json) {
    if (json['pagination_meta'] != null) {
      paginationMeta = PaginationMeta.fromJson(json['pagination_meta']);
      if (json['data'] != null) {
        json['data'].forEach((v) {
          dataItems!.add(DataItems.fromJson(v));
        });
      }
    }
  }
}

class PaginationMeta {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;
  bool? canLoadMore;

  PaginationMeta(
      {this.currentPage,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.canLoadMore});

  PaginationMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    canLoadMore = json['can_load_more'];
  }
}

class DataItems {
  int? id;
  String? type;
  String? name;
  String? phoneNo;
  String? bishopName;
  Province? province;

  DataItems(
      {this.id,
      this.name,
      this.type,
      this.bishopName,
      this.phoneNo,
      this.province});

  DataItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    phoneNo = json['phone_no'];
    bishopName = json['bishop_name'];
    if (json['province'] != null) {
      province = Province.fromJson(json['province']);
    }
  }
}

class Province {
  int? id;
  String? name;
  String? areaCovered;

  Province({this.id, this.name, this.areaCovered});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaCovered = json['area_covered'];
  }
}
