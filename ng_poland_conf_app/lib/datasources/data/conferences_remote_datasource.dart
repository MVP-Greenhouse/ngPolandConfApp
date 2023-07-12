import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/contentful_constants.dart';
import 'package:ng_poland_conf_app/datasources/models/conferences.dart';
import 'package:ng_poland_conf_app/datasources/models/event_types.dart';

abstract class ConferencesRemoteDataSource {
  Future<List<Conferences>> getAllConferences();

  Future<Conferences> getNewestConference();
}

@Singleton(as: ConferencesRemoteDataSource)
class ConferencesRemoteDataSourceImpl implements ConferencesRemoteDataSource {
  @override
  Future<List<Conferences>> getAllConferences() async {
    Dio dio = Dio();

    var response = await dio.get(
      ContentfulConstants.contentfulUrl(
        contentType: EventContentTypes.conferences.name,
      ),
    );

    dynamic dataDecode = jsonDecode(response.toString());

    List<Conferences> listConferences = dataDecode['items']
        .map<Conferences>(
          (dynamic e) => Conferences.fromJson(e['fields']),
        )
        .toList();

    listConferences.sort(
      (a, b) => a.confId.compareTo(b.confId),
    );

    return listConferences;
  }

  @override
  Future<Conferences> getNewestConference() async {
    Conferences? conferences;

    List<Conferences> allConferences = await getAllConferences();

    conferences = allConferences.last;

    return conferences;
  }
}
