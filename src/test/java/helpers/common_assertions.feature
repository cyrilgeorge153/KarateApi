Feature: common assertions feature

  Scenario: common assertions scenario
    * def validateResponse =
      """
      function() {
            var contentType = karate.get("responseHeaders['Content-Type'][0]");
            if (contentType !== 'application/json; charset=utf-8') {
              karate.fail('content type is not json');
            }
            var responseType = karate.get('responseType');
            if (responseType !== 'json') {
              karate.fail('response type is not json');
            }
            var responseTime = karate.get('responseTime');
            if (responseTime > 5000) {
              karate.fail('response is too slow');
            }
          }   
      """
