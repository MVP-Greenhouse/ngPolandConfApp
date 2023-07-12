import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContentfulConstants {
  ContentfulConstants._();

  static final String? _accessToken = dotenv.env['access_token'];
  static final String? _spaceId = dotenv.env['space_id'];

  static const String _url = 'https://cdn.contentful.com/';

  static String contentfulUrl({
    String? contentType,
    String? locale,
    List<String>? fields,
    String? limit,
    String? order,
  }) {
    String url = '${_url}spaces/$_spaceId/environments/master/entries?access_token=$_accessToken';

    if (contentType != null) url += '&content_type=$contentType';

    if (locale != null) url += '&locale=$locale';

    if (fields != null) url += _fieldsForUrl(fields);

    if (limit != null) url += '&limit=$limit';

    if (order != null) url += '&order=$order';

    return url;
  }

  static String _fieldsForUrl(List<String> fields) {
    String fieldsInString = '';

    for (final String field in fields) {
      fieldsInString += '&fields.$field';
    }

    return fieldsInString;
  }
}
