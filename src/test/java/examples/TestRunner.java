package examples;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("/users/reqres").relativeTo(getClass());
    }    

}
