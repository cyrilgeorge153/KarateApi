package com.tests.restfulbooker;

import com.intuit.karate.junit5.Karate;

class RestfulBookerTestRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("restfulbooker").relativeTo(getClass());
    }
}
