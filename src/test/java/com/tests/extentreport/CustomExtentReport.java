package com.tests.extentreport;

import java.util.stream.Stream;
import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.gherkin.model.And;
import com.aventstack.extentreports.gherkin.model.Feature;
import com.aventstack.extentreports.gherkin.model.Given;
import com.aventstack.extentreports.gherkin.model.Scenario;
import com.aventstack.extentreports.gherkin.model.Then;
import com.aventstack.extentreports.gherkin.model.When;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;
import com.intuit.karate.Results;
import com.intuit.karate.core.Result;
import com.intuit.karate.core.ScenarioResult;
import com.intuit.karate.core.Step;

public class CustomExtentReport {
	private ExtentReports extentReports;
	private ExtentSparkReporter extentSparkReporter;
	private String reportDir;
	private String reportTitle = "Karate Test Execution Report";
	private Results testResults;
	private ExtentTest featureNode;
	private String featureTitle = "";
	private ExtentTest scenarioNode;
	private String scenarioTitle = "";

	public CustomExtentReport() {
		extentReports = new ExtentReports();
	}
	public CustomExtentReport withReportDir(String reportDir) {
		this.reportDir = reportDir;
		return this;
	}
	public CustomExtentReport withKarateResult(Results testResults) {
		this.testResults = testResults;
		return this;
	}
	public CustomExtentReport withReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
		return this;
	}
	public void generateExtentReport() {
		if (this.reportDir != null && !this.reportDir.isEmpty() && this.testResults != null) {
			extentSparkReporter = new ExtentSparkReporter(reportDir);
			extentReports.attachReporter(extentSparkReporter);
			setConfig();
			Stream<ScenarioResult> scenarioResults = getScenarioResults();
			scenarioResults.forEach((scenarioResult) -> {
				String featureName = getFeatureName(scenarioResult);
				String featureDesc = getFeatureDesc(scenarioResult);
				ExtentTest featureNode = createFeatureNode(featureName, featureDesc);
				String scenarioTitle = getSecnarioTitle(scenarioResult);
				ExtentTest scenarioNode = createScenarioNode(featureNode, scenarioTitle);
				scenarioResult.getStepResults().forEach((step) -> {
					addScenarioStep(scenarioNode, step.getStep(), step.getResult(), step.getStepLog());
				});
			});
			extentReports.flush();
			return;
		}
		throw new RuntimeException("Missing the Karate Test Result / Report Dir location");
	}
	private Stream<ScenarioResult> getScenarioResults() {
		return this.testResults.getScenarioResults();
	}
	private String getFeatureName(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getName();
	}
	private String getFeatureDesc(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getDescription();
	}
	private ExtentTest createFeatureNode(String featureName, String featureDesc) {
		if (this.featureTitle.equalsIgnoreCase(featureName)) {
			return featureNode;
		}
		this.featureTitle = featureName;
		featureNode = extentReports.createTest(Feature.class, featureName, featureDesc);
		return featureNode;
	}
	private ExtentTest createScenarioNode(ExtentTest featureNode, String scenarioTitle) {
		if (this.scenarioTitle.equalsIgnoreCase(scenarioTitle)) {
			return scenarioNode;
		}
		this.scenarioTitle = scenarioTitle;
		scenarioNode = featureNode.createNode(Scenario.class, scenarioTitle);
		return scenarioNode;
	}
	private String getSecnarioTitle(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getName();
	}
	private void addScenarioStep(ExtentTest scenarioNode, Step step, Result stepResult, String stepLogs) {
		String type = step.getPrefix();
		String stepTitle = step.getText();
		String status = stepResult.getStatus();
		Throwable error = stepResult.getError();
		ExtentTest stepNode;
		switch (type) {
		case "Given":
			stepNode = scenarioNode.createNode(Given.class, getStepTitle(type, stepTitle));
			addStatus(stepNode, status, error, stepLogs);
			break;
		case "When":
			stepNode = scenarioNode.createNode(When.class, getStepTitle(type, stepTitle));
			addStatus(stepNode, status, error, stepLogs);
			break;
		case "Then":
			stepNode = scenarioNode.createNode(Then.class, getStepTitle(type, stepTitle));
			addStatus(stepNode, status, error, stepLogs);
			break;
		case "And":
			stepNode = scenarioNode.createNode(And.class, getStepTitle(type, stepTitle));
			addStatus(stepNode, status, error, stepLogs);
			break;
		default:
			stepNode = scenarioNode.createNode(type + " " + getStepTitle(type, stepTitle));
			addStatus(stepNode, status, error, stepLogs);
			break;
		}
	}
	private String getStepTitle(String type, String stepText) {
		return type.startsWith("*") ? stepText : type + " " + stepText;
	}
	private void addStatus(ExtentTest stepNode, String status, Throwable error, String stepLogs) {
		switch (status) {
		case "passed":
			stepNode.pass("");
			break;
		case "failed":
			stepNode.fail(error);
			break;
		default:
			stepNode.skip("");
			break;
		}
		if (stepLogs != null && !stepLogs.isEmpty())
			stepNode.info(String.format("[print] %s", stepLogs));
	}
	private void setConfig() {
		extentSparkReporter.config().enableOfflineMode(true);
		extentSparkReporter.config().setDocumentTitle(reportTitle);
		extentSparkReporter.config().setTimelineEnabled(true);
		extentSparkReporter.config().setTheme(Theme.DARK);
		extentReports.setSystemInfo("Tester", "Cyril");
		extentReports.setSystemInfo("Operating_System", System.getProperty("os.name"));
		extentReports.setSystemInfo("Java_Version", System.getProperty("java.version"));
	}
}
