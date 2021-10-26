package examples.reqres;

import com.intuit.karate.junit5.Karate;

class ReqresTestRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("reqres").relativeTo(getClass());
    }
}
