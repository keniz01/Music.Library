#tool "nuget:?package=ReportGenerator&version=4.5.5"
#tool "nuget:?package=roundhouse&version=1.2.1"
#addin "nuget:?package=Cake.Coverlet&version=2.4.2"

var target = Argument("target", "default");
var configuration = Argument("configuration", "debug");
var solutionPath = "../../src/Music.Library.sln";

Task("restore").Does(() => DotNetCoreRestore(solutionPath));

Task("build").Does(() => DotNetCoreBuild(solutionPath, new DotNetCoreBuildSettings { Configuration = "Debug" }));

Task("clean").Does(() => DotNetCoreClean(solutionPath, new DotNetCoreCleanSettings { Configuration = "Debug" }));

Task("tests")
 .Does(() =>
 {	
	var testSettings = new DotNetCoreTestSettings
	{
		Configuration = configuration
	};
	var codeCoverageOutput = MakeAbsolute(Directory("../../testresults/"));	
	var coverletSettings = new CoverletSettings
	{
            CollectCoverage = true,
            CoverletOutputDirectory = codeCoverageOutput,			
            CoverletOutputFormat = CoverletOutputFormat.cobertura         
	};

	CleanDirectories("../../testresults/");

	var projects = GetFiles("../../src/tests/music.library.tests/*.Tests/*.csproj");

	foreach(var project in projects)
	{				
		coverletSettings.CoverletOutputName = $"coverage_cobertura_{DateTime.UtcNow:dd-MM-yyyy-HH-mm-ss-FFF}.xml";
		DotNetCoreTest(project.FullPath, testSettings, coverletSettings);			
	}

	ReportGenerator($"{codeCoverageOutput}/*.xml", codeCoverageOutput);
 });

Task("database")
	.Does(() => 
	{
		RoundhouseMigrate(new RoundhouseSettings{
			Silent = true,
			ServerName = "(local)",
			DatabaseName = "MusicContent",
			SqlFilesDirectory = "../../database/sql",
			ConnectionString = "server=(local);database=MusicContent;User id=sa;Password=P@55w0rd"
		});
	});

Task("default") 
  .IsDependentOn("clean")
  .IsDependentOn("restore")
  .IsDependentOn("build");  

Task("full") 
  .IsDependentOn("database")
  .IsDependentOn("default") 
  .IsDependentOn("tests");    

RunTarget(target);