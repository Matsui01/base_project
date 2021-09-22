// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.chucknorris.io/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Joke> getJokes({options}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(<String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'GET',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: '/jokes/random')
      ..data = _data);
    final value = Joke.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Joke> getJokes1(contentType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Joke>(
        Options(
                method: 'GET',
                headers: <String, dynamic>{r'Content-Type': contentType},
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/jokes/random',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Joke.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Joke> getJasks2() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Joke>(
        Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Custom-Header': 'Your header'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, '/jokes/random',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Joke.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Joke> getJoke(contentType, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Joke>(
        Options(
                method: 'GET',
                headers: <String, dynamic>{r'Content-Type': contentType},
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/jokes/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Joke.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> queries(queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/jokes',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> namedExample(apiKey, scope, type, from) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'scope': scope,
      r'type': type,
      r'from': from
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'https://httpbin.org/get',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions newRequestOptions(Options? options) {
    if (options is RequestOptions) {
      return options as RequestOptions;
    }
    if (options == null) {
      return RequestOptions(path: '');
    }
    return RequestOptions(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      responseType: options.responseType,
      contentType: options.contentType.toString(),
      validateStatus: options.validateStatus,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      requestEncoder: options.requestEncoder,
      responseDecoder: options.responseDecoder,
      path: '',
    );
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
