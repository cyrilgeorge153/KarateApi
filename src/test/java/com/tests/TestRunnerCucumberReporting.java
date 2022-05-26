package com.tests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

public class TestRunnerCucumberReporting {
	
    @Test
    public void testParallel() {
        Results results = Runner.path("classpath:com/tests")
                .tags("~@ignore")
                .outputCucumberJson(true)
                .parallel(35);
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Karate Api Testing");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
    @AfterAll
    public static void tearDown() {
        try {
            Desktop.getDesktop()
                    .browse(new File("target/cucumber-html-reports/overview-features.html").toURI());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
