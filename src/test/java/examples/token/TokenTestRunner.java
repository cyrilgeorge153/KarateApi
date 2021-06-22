package examples.token;

import com.intuit.karate.junit5.Karate;

class TokenTestRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("token").relativeTo(getClass());
    }    

}
