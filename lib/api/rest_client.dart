import 'package:dio/dio.dart';

import '../http.dart';

class RestClient {
  final String devUrl = "https://dev.api.atendimento.satturno.com.br";
  final String prodUrl = "https://api";

  String accessToken = "";
  String refreshToken = "";
  String authorizationType = "Bearer";

  static int clientID = 3;
  static String clientSecret = "EDX3Ct6xqaRl69WG79aRuHCyXuJ1VlOUy6wbkWlt";
  static String refreshType = "refresh_token";
  static String passwordType = "password";
  // {"Content-type": "application/json", "Authorization": "access_token: Asgs~[3tdg5h`]/"};

  restClientInit() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: devUrl,
      connectTimeout: 10000,
      receiveTimeout: 8000,
      headers: {
        "Authorization": "$authorizationType $accessToken",
      },
    );

    BaseOptions tokenOptions = BaseOptions(
      baseUrl: devUrl,
      connectTimeout: 10000,
      receiveTimeout: 8000,
      headers: {
        // "Authorization": "$authorizationType $refreshToken",
      },
    );

    dio = Dio(baseOptions);
    tokenDio = Dio(tokenOptions);

    /// [onRequets] É chamado antes do envio da requisição
    /// Caso não haja um token, requisite o token e trave o interceptor para outras requisições

    /// [onResponse] Resposta da requisição

    /// [onError] Resposta com erro
    /// Caso a resposta seja 401 executa o refresh token
    /// trava todas as requisições
    /// logo em seguida tenta a requisição novamente

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Caso não tenha token, tente obter o token primeiramente, e trave o interceptor.
        // Para prevenir que outra requisição entre em ação
        if (accessToken.isEmpty || refreshToken.isEmpty) {
          dio.interceptors.requestLock.lock();
          tokenDio.get('/oauth/token').then((response) {
            options.headers["Authorization"] = "$authorizationType $accessToken";
            tokenDio.options.headers["Authorization"] = "$authorizationType $refreshToken";
            handler.next(options);
          }).catchError((error, stackTrace) {
            handler.reject(error, true);
          }).whenComplete(() => dio.interceptors.requestLock.unlock());
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        if (e.response?.statusCode == 401) {
          var options = e.response!.requestOptions;
          // Se o token foi atualizado em outra requisição
          if ("$authorizationType $accessToken" != options.headers["Authorization"]) {
            options.headers["Authorization"] = "$authorizationType $accessToken";
            tokenDio.options.headers["Authorization"] = "$authorizationType $refreshToken";
            // repeat
            dio.fetch(options).then(
              (r) => handler.resolve(r),
              onError: (e) {
                handler.reject(e);
              },
            );
            return;
          }

          dio.lock();
          dio.interceptors.responseLock.lock();
          dio.interceptors.errorLock.lock();

          // Refresh
          tokenDio.post('/oauth/token', data: {
            "client_id": clientID,
            "client_secret": clientSecret,
            "grant_type": refreshType,
            "refresh_token": refreshToken,
          }).then((d) {
            accessToken = d.data['access_token'];
            refreshToken = d.data['refresh_token'];
            options.headers["Authorization"] = "$authorizationType $accessToken";
            tokenDio.options.headers["Authorization"] = "$authorizationType $refreshToken";
          }).whenComplete(() {
            dio.unlock();
            dio.interceptors.responseLock.unlock();
            dio.interceptors.errorLock.unlock();
          }).then((e) {
            dio.fetch(options).then(
              (r) => handler.resolve(r),
              onError: (e) {
                handler.reject(e);
              },
            );
          });
          return;
        }
        return handler.next(e);
      },
    ));
  }
}
