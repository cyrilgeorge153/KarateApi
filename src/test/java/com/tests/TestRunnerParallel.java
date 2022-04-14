package com.tests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;
import java.awt.*;
import java.io.File;
import java.io.IOException;

class TestRunnerParallel {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:com/tests")
                .tags("~@ignore")
                //.outputCucumberJson(true)
                .parallel(22);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    @AfterAll
    public static void tearDown() {
        try {
            Desktop.getDesktop()
                    .browse(new File("target/karate-reports/karate-summary.html").toURI());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
