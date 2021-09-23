import 'package:dio/dio.dart';

class RestClient {
  void httpInit() async {
    var options = BaseOptions(
      baseUrl: 'https://www.xx.com/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options); // with default Options

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }

  void getHttp1() async {
    var dio = Dio();
    Response response = await dio.get('/test?id=12&name=wendu');
    response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
    print(response.data);
  }

  void getHttp2() async {
    var dio = Dio(); // with default Options
    var response = await dio.request(
      '/test',
      data: {'id': 12, 'name': 'xx'},
      options: Options(
        method: 'GET',
        responseType: ResponseType.json,
      ),
    );
  }
}
