import 'package:base_project/models/joke.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.chucknorris.io/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/jokes/random')
  Future<Joke> getJokes({@DioOptions() Options? options});

  // HEADERS EXAMPLE
  @GET("/jokes/random")
  Future<Joke> getJokes1(@Header("Content-Type") String contentType);

  // STATIC HEADERS EXAMPLE
  @GET("/jokes/random")
  @Headers(<String, dynamic>{"Content-Type": "application/json", "Custom-Header": "Your header"})
  Future<Joke> getJasks2();

  @GET("/jokes/{id}")
  Future<Joke> getJoke(@Header("Content-Type") String contentType, @Path("id") String id);

  @GET('/jokes')
  Future<String> queries(@Queries() Map<String, dynamic> queries);

  //AINDA NAO SEI PARA QUE SERVE ;-;
  @GET("https://httpbin.org/get")
  Future<String> namedExample(@Query("apikey") String apiKey, @Query("scope") String scope, @Query("type") String type, @Query("from") int from);

  // @PATCH("/jokes/{id}")
  // Future<Joke> updateJokePart(
  //     @Path() String id, @Body() Map<String, dynamic> map);

  // @PUT("/jokes/{id}")
  // Future<Joke> updateJoke(@Path() String id, @Body() Joke Joke);

  // @DELETE("/jokes/{id}")
  // Future<void> deleteJoke(@Path() String id);

  // @POST("/jokes")
  // Future<Joke> createJoke(@Body() Joke Joke);

  // @POST("http://httpbin.org/post")
  // Future<void> createNewJokeFromFile(@Part() File file);

  // @POST("http://httpbin.org/post")
  // @FormUrlEncoded()
  // Future<String> postUrlEncodedFormData(@Field() String hello);
}
