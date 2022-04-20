package com.tests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner.Builder;
import com.tests.extentreport.CustomExtentReport;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

public class TestRunnerExtentReport {
	
	@Test
	public void executeKarateTest() {
		Builder aRunner = new Builder();
		aRunner.path("classpath:com/tests").tags("~@ignore");
		Results result = aRunner.parallel(26);
		// Extent Report
		CustomExtentReport extentReport = new CustomExtentReport().withKarateResult(result)
				.withReportDir(result.getReportDir()).withReportTitle("Karate Test Execution Report");
		extentReport.generateExtentReport();
	}
	@AfterAll
    public static void tearDown() {
        try {
            Desktop.getDesktop()
                    .browse(new File("target/karate-reports/Index.html").toURI());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
