#tool "nuget:?package=OpenCover&version=4.7.922"
#tool "nuget:?package=ReportGenerator&version=4.5.5"

var target = Argument("target", "Default");
var configuration = Argument("configuration", "Debug");
var solutionPath = "../../src/Music.Library.sln";

Task("Restore-NuGet-Packages").Does(() => DotNetCoreRestore(solutionPath));
Task("Build").Does(() => DotNetCoreBuild(solutionPath, new DotNetCoreBuildSettings { Configuration = "Debug" }));
Task("Clean").Does(() => 
	{
		DotNetCoreClean(solutionPath, new DotNetCoreCleanSettings { Configuration = "Debug" });
	});

Task("Run-Unit-Tests")
 .Does(() =>
 {	
	var openCoverSettings = new OpenCoverSettings
    {
        OldStyle = true,
        MergeOutput = true
    };
	
	var dotNetTestSettings = new DotNetCoreTestSettings
	{
		Configuration = configuration
	};
	
	var coverageReportDir = "../../reports";
	CleanDirectories(coverageReportDir);
	
	var coverageReport = new FilePath($"{coverageReportDir}/coverage_results.xml");
	
	var projects = GetFiles("../../src/*.Tests/*.csproj");
	
	foreach(var project in projects)
	{				
		DotNetCoreTest(project.FullPath, dotNetTestSettings);
		OpenCover(context => context.DotNetCoreTest(project.FullPath, dotNetTestSettings), coverageReport, openCoverSettings);			
	}
	
	ReportGenerator(coverageReport, coverageReportDir);	
 });

Task("Default") 
  .IsDependentOn("Run-Unit-Tests");

RunTarget(target);