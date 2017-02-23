program Tests_StringDistance;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  StringDistance.DamerauLevenshtein in 'StringDistance.DamerauLevenshtein.pas',
  StringDistance.Levenshtein in 'StringDistance.Levenshtein.pas',
  StringDistance.OptimalStringAlignment in 'StringDistance.OptimalStringAlignment.pas',
  StringDistance in 'StringDistance.pas',
  Tests.StringDistanceAlgorithms in 'Tests.StringDistanceAlgorithms.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;
  Logger: ITestLogger;
  NunitLogger: ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  Exit;
{$ENDIF}

  try
    // Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    // Create the test runner
    Runner := TDUnitX.CreateRunner;
    // Tell the runner to use RTTI to find Fixtures
    Runner.UseRTTI := True;
    // tell the runner how we will log things
    // Log to the console window
    Logger := TDUnitXConsoleLogger.Create(True);
    Runner.AddLogger(Logger);
    // Generate an NUnit compatible XML File
    NunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    Runner.AddLogger(NunitLogger);
    Runner.FailsOnNoAsserts := False; // When true, Assertions must be made during tests;

    // Run tests
    Results := Runner.Execute;
    if not Results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

{$IFNDEF CI}
    // We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
{$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;

end.
