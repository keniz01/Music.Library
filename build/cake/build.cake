#tool "nuget:?package=OpenCover&version=4.7.922"
#tool "nuget:?package=ReportGenerator&version=4.5.5"

var target = Argument("target", "default");
var configuration = Argument("configuration", "debug");
var solutionPath = "../../src/Music.Library.sln";

Task("restore").Does(() => DotNetCoreRestore(solutionPath));
Task("build").Does(() => DotNetCoreBuild(solutionPath, new DotNetCoreBuildSettings { Configuration = "Debug" }));
Task("clean").Does(() => DotNetCoreClean(solutionPath, new DotNetCoreCleanSettings { Configuration = "Debug" }));

Task("tests")
 .Does(() =>
 {	
	var dotNetTestSettings = new DotNetCoreTestSettings
	{
		Configuration = configuration
	};
	
	var projects = GetFiles("../../src/tests/music.library.tests/*.Tests/*.csproj");
	
	foreach(var project in projects)
	{				
		DotNetCoreTest(project.FullPath, dotNetTestSettings);		
	}
 });
 
Task("codecoverage")
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
	var projects = GetFiles("../../src/tests/music.library.tests/*.Tests/*.csproj");
	
	foreach(var project in projects)
	{				
		OpenCover(context => context.DotNetCoreTest(project.FullPath, dotNetTestSettings), coverageReport, openCoverSettings);			
	}
	
	ReportGenerator(coverageReport, coverageReportDir);	
 });

Task("default") 
  .IsDependentOn("restore")
  .IsDependentOn("clean")
  .IsDependentOn("build");  

Task("full") 
  .IsDependentOn("restore")
  .IsDependentOn("clean")
  .IsDependentOn("build")
  .IsDependentOn("tests")
  .IsDependentOn("codecoverage");    

RunTarget(target);