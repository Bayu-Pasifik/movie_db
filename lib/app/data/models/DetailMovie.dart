// To parse this JSON data, do
//
//     final detailMovie = detailMovieFromJson(jsonString);

import 'dart:convert';

DetailMovie detailMovieFromJson(String str) =>
    DetailMovie.fromJson(json.decode(str));

String detailMovieToJson(DetailMovie data) => json.encode(data.toJson());

class DetailMovie {
  DetailMovie({
    this.id,
    this.title,
    this.originalTitle,
    this.fullTitle,
    this.type,
    this.year,
    this.image,
    this.releaseDate,
    this.runtimeMins,
    this.runtimeStr,
    this.plot,
    this.plotLocal,
    this.plotLocalIsRtl,
    this.awards,
    this.directors,
    this.directorList,
    this.writers,
    this.writerList,
    this.stars,
    this.starList,
    this.actorList,
    this.fullCast,
    this.genres,
    this.genreList,
    this.companies,
    this.companyList,
    this.countries,
    this.countryList,
    this.languages,
    this.languageList,
    this.contentRating,
    this.imDbRating,
    this.imDbRatingVotes,
    this.metacriticRating,
    this.ratings,
    this.wikipedia,
    this.posters,
    this.images,
    this.trailer,
    this.boxOffice,
    this.tagline,
    this.keywords,
    this.keywordList,
    this.similars,
    this.tvSeriesInfo,
    this.tvEpisodeInfo,
    this.errorMessage,
  });

  String? id;
  String? title;
  String? originalTitle;
  String? fullTitle;
  String? type;
  String? year;
  String? image;
  DateTime? releaseDate;
  dynamic runtimeMins;
  dynamic runtimeStr;
  String? plot;
  String? plotLocal;
  bool? plotLocalIsRtl;
  String? awards;
  String? directors;
  List<dynamic>? directorList;
  String? writers;
  List<dynamic>? writerList;
  String? stars;
  List<dynamic>? starList;
  List<dynamic>? actorList;
  dynamic fullCast;
  String? genres;
  List<CountryListElement>? genreList;
  String? companies;
  List<CompanyListElement>? companyList;
  String? countries;
  List<CountryListElement>? countryList;
  String? languages;
  List<CountryListElement>? languageList;
  String? contentRating;
  String? imDbRating;
  String? imDbRatingVotes;
  String? metacriticRating;
  dynamic ratings;
  dynamic wikipedia;
  dynamic posters;
  dynamic images;
  dynamic trailer;
  BoxOffice? boxOffice;
  dynamic tagline;
  String? keywords;
  List<String>? keywordList;
  List<Similar>? similars;
  TvSeriesInfo? tvSeriesInfo;
  dynamic tvEpisodeInfo;
  String? errorMessage;

  factory DetailMovie.fromJson(Map<String, dynamic> json) => DetailMovie(
        id: json["id"],
        title: json["title"],
        originalTitle: json["originalTitle"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        image: json["image"],
        releaseDate: json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        plotLocal: json["plotLocal"],
        plotLocalIsRtl: json["plotLocalIsRtl"],
        awards: json["awards"],
        directors: json["directors"],
        directorList: json["directorList"] == null
            ? []
            : List<dynamic>.from(json["directorList"]!.map((x) => x)),
        writers: json["writers"],
        writerList: json["writerList"] == null
            ? []
            : List<dynamic>.from(json["writerList"]!.map((x) => x)),
        stars: json["stars"],
        starList: json["starList"] == null
            ? []
            : List<dynamic>.from(json["starList"]!.map((x) => x)),
        actorList: json["actorList"] == null
            ? []
            : List<dynamic>.from(json["actorList"]!.map((x) => x)),
        fullCast: json["fullCast"],
        genres: json["genres"],
        genreList: json["genreList"] == null
            ? []
            : List<CountryListElement>.from(
                json["genreList"]!.map((x) => CountryListElement.fromJson(x))),
        companies: json["companies"],
        companyList: json["companyList"] == null
            ? []
            : List<CompanyListElement>.from(json["companyList"]!
                .map((x) => CompanyListElement.fromJson(x))),
        countries: json["countries"],
        countryList: json["countryList"] == null
            ? []
            : List<CountryListElement>.from(json["countryList"]!
                .map((x) => CountryListElement.fromJson(x))),
        languages: json["languages"],
        languageList: json["languageList"] == null
            ? []
            : List<CountryListElement>.from(json["languageList"]!
                .map((x) => CountryListElement.fromJson(x))),
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingVotes: json["imDbRatingVotes"],
        metacriticRating: json["metacriticRating"],
        ratings: json["ratings"],
        wikipedia: json["wikipedia"],
        posters: json["posters"],
        images: json["images"],
        trailer: json["trailer"],
        boxOffice: json["boxOffice"] == null
            ? null
            : BoxOffice.fromJson(json["boxOffice"]),
        tagline: json["tagline"],
        keywords: json["keywords"],
        keywordList: json["keywordList"] == null
            ? []
            : List<String>.from(json["keywordList"]!.map((x) => x)),
        similars: json["similars"] == null
            ? []
            : List<Similar>.from(
                json["similars"]!.map((x) => Similar.fromJson(x))),
        tvSeriesInfo: json["tvSeriesInfo"] == null
            ? null
            : TvSeriesInfo.fromJson(json["tvSeriesInfo"]),
        tvEpisodeInfo: json["tvEpisodeInfo"],
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalTitle": originalTitle,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "image": image,
        "releaseDate":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "runtimeMins": runtimeMins,
        "runtimeStr": runtimeStr,
        "plot": plot,
        "plotLocal": plotLocal,
        "plotLocalIsRtl": plotLocalIsRtl,
        "awards": awards,
        "directors": directors,
        "directorList": directorList == null
            ? []
            : List<dynamic>.from(directorList!.map((x) => x)),
        "writers": writers,
        "writerList": writerList == null
            ? []
            : List<dynamic>.from(writerList!.map((x) => x)),
        "stars": stars,
        "starList":
            starList == null ? [] : List<dynamic>.from(starList!.map((x) => x)),
        "actorList": actorList == null
            ? []
            : List<dynamic>.from(actorList!.map((x) => x)),
        "fullCast": fullCast,
        "genres": genres,
        "genreList": genreList == null
            ? []
            : List<dynamic>.from(genreList!.map((x) => x.toJson())),
        "companies": companies,
        "companyList": companyList == null
            ? []
            : List<dynamic>.from(companyList!.map((x) => x.toJson())),
        "countries": countries,
        "countryList": countryList == null
            ? []
            : List<dynamic>.from(countryList!.map((x) => x.toJson())),
        "languages": languages,
        "languageList": languageList == null
            ? []
            : List<dynamic>.from(languageList!.map((x) => x.toJson())),
        "contentRating": contentRating,
        "imDbRating": imDbRating,
        "imDbRatingVotes": imDbRatingVotes,
        "metacriticRating": metacriticRating,
        "ratings": ratings,
        "wikipedia": wikipedia,
        "posters": posters,
        "images": images,
        "trailer": trailer,
        "boxOffice": boxOffice?.toJson(),
        "tagline": tagline,
        "keywords": keywords,
        "keywordList": keywordList == null
            ? []
            : List<dynamic>.from(keywordList!.map((x) => x)),
        "similars": similars == null
            ? []
            : List<dynamic>.from(similars!.map((x) => x.toJson())),
        "tvSeriesInfo": tvSeriesInfo?.toJson(),
        "tvEpisodeInfo": tvEpisodeInfo,
        "errorMessage": errorMessage,
      };
}

class BoxOffice {
  BoxOffice({
    this.budget,
    this.openingWeekendUsa,
    this.grossUsa,
    this.cumulativeWorldwideGross,
  });

  String? budget;
  String? openingWeekendUsa;
  String? grossUsa;
  String? cumulativeWorldwideGross;

  factory BoxOffice.fromJson(Map<String, dynamic> json) => BoxOffice(
        budget: json["budget"],
        openingWeekendUsa: json["openingWeekendUSA"],
        grossUsa: json["grossUSA"],
        cumulativeWorldwideGross: json["cumulativeWorldwideGross"],
      );

  Map<String, dynamic> toJson() => {
        "budget": budget,
        "openingWeekendUSA": openingWeekendUsa,
        "grossUSA": grossUsa,
        "cumulativeWorldwideGross": cumulativeWorldwideGross,
      };
}

class CompanyListElement {
  CompanyListElement({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory CompanyListElement.fromJson(Map<String, dynamic> json) =>
      CompanyListElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CountryListElement {
  CountryListElement({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory CountryListElement.fromJson(Map<String, dynamic> json) =>
      CountryListElement(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class Similar {
  Similar({
    this.id,
    this.title,
    this.image,
    this.imDbRating,
  });

  String? id;
  String? title;
  String? image;
  String? imDbRating;

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imDbRating: json["imDbRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imDbRating": imDbRating,
      };
}

class TvSeriesInfo {
  TvSeriesInfo({
    this.yearEnd,
    this.creators,
    this.creatorList,
    this.seasons,
  });

  String? yearEnd;
  String? creators;
  List<CompanyListElement>? creatorList;
  List<String>? seasons;

  factory TvSeriesInfo.fromJson(Map<String, dynamic> json) => TvSeriesInfo(
        yearEnd: json["yearEnd"],
        creators: json["creators"],
        creatorList: json["creatorList"] == null
            ? []
            : List<CompanyListElement>.from(json["creatorList"]!
                .map((x) => CompanyListElement.fromJson(x))),
        seasons: json["seasons"] == null
            ? []
            : List<String>.from(json["seasons"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "yearEnd": yearEnd,
        "creators": creators,
        "creatorList": creatorList == null
            ? []
            : List<dynamic>.from(creatorList!.map((x) => x.toJson())),
        "seasons":
            seasons == null ? [] : List<dynamic>.from(seasons!.map((x) => x)),
      };
}
