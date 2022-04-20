package com.tests.calljava;

import com.intuit.karate.junit5.Karate;

class JavaClassTestRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("calljavaclass").relativeTo(getClass());
    }
}
