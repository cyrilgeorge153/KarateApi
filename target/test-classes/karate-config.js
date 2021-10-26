function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    base_url: 'https://reqres.in/api',
    single_user_path: '/users/2',
    all_user_path: '/users?page=2',
    postman_basic_auth_url: 'https://postman-echo.com/basic-auth/',
    restful_booker_base_url: 'https://restful-booker.herokuapp.com/booking'
  };
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  var result = karate.callSingle('classpath:examples/preconditions/presteps.feature', config);
  config.token = result.token; // assuming you did 'def token'
  config.booking_id=result.booking_id
  return config;
}