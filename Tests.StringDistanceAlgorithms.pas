unit Tests.StringDistanceAlgorithms;

interface

uses
  DUnitX.TestFramework,
  StringDistance;

type
{$REGION 'TestLevenshteinDistance'}
  [TestFixture]
  TestLevenshteinDistance = class
  strict private
    FSUT: IStringDistance;
  strict protected
    property SUT: IStringDistance read FSUT;
  public
    [Setup] procedure Setup;
    [Test]
    [TestCase('kitten vs sitting --> edit distance = 3', 'kitten,sitting,3')]
    [TestCase('Kitten vs Sitting --> edit distance = 3', 'Kitten,Sitting,3')]
    [TestCase('Kitten vs sitting --> edit distance = 3', 'Kitten,sitting,3')]
    [TestCase('Casa vs Calle --> edit distance = 3', 'Casa,Calle,3')]
    [TestCase('cow vs coy --> edit distance = 1', 'cow,coy,1')]
    [TestCase('teusday vs tuesday --> edit distance = 2', 'teusday,tuesday,2')]
    [TestCase('teusday vs thursday --> edit distance = 2', 'teusday,thursday,2')]
    [TestCase('EmptyStr vs EmptyStr --> edit distance = 0', ',,0')]
    procedure TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
  end;
{$ENDREGION}

{$REGION 'TestOptimalStringAlignmentDistance'}
  [TestFixture]
  TestOptimalStringAlignmentDistance = class
  strict private
    FSUT: IStringDistance;
  strict protected
    property SUT: IStringDistance read FSUT;
  public
    [Setup] procedure Setup;
    [Test]
    [TestCase('CA vs ABC --> edit distance = 3', 'CA,ABC,3')]
    [TestCase('Something vs Smoething --> edit distance = 1', 'Something,Smoething,1')]
    [TestCase('smtih vs smith --> edit distance = 1', 'smtih,smith,1')]
    [TestCase('snapple vs apple --> edit distance = 2', 'snapple,apple,2')]
    [TestCase('testing vs testtn --> edit distance = 2', 'testing,testtn,2')]
    [TestCase('saturday vs sunday --> edit distance = 3', 'saturday,sunday,3')]
    [TestCase('Saturday vs saturday --> edit distance = 1', 'Saturday,saturday,1')]
    [TestCase('orange vs pumpkin --> edit distance = 7', 'orange,pumpkin,7')]
    [TestCase('gifts vs profit --> edit distance = 5', 'gifts,profit,5')]
    [TestCase('Sjöstedt vs Sjostedt --> edit distance = 1', 'Sjöstedt,Sjostedt,1')]
    [TestCase('EmptyStr vs EmptyStr --> edit distance = 0', ',,0')]
    procedure TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
  end;
{$ENDREGION}

{$REGION 'TestDamerauLevenshteinDistance'}
  [TestFixture]
  TestDamerauLevenshteinDistance = class
  strict private
    FSUT: IStringDistance;
  strict protected
    property SUT: IStringDistance read FSUT;
  public
    [Setup] procedure Setup;
    [Test]
    [TestCase('CA vs ABC --> edit distance = 2', 'CA,ABC,2')]
    [TestCase('tuesday vs something --> edit distance = 8', 'tuesday,something,8')]
    [TestCase('snapple vs apple --> edit distance = 2', 'snapple,apple,2')]
    [TestCase('saturday vs sunday --> edit distance = 3', 'saturday,sunday,3')]
    [TestCase('Saturday vs saturday --> edit distance = 1', 'Saturday,saturday,1')]
    [TestCase('orange vs pumpkin --> edit distance = 7', 'orange,pumpkin,7')]
    [TestCase('gifts vs profit --> edit distance = 5', 'gifts,profit,5')]
    [TestCase('Sjöstedt vs Sjostedt --> edit distance = 2', 'Sjöstedt,Sjostedt,2')]
    [TestCase('abc vs cba --> edit distance = 2', 'abc,cba,2')]
    [TestCase('abcdef vs cba --> edit distance = 5', 'abcdef,cba,5')]
    [TestCase('ac vs ca --> edit distance = 1', 'ac,ca,1')]
    [TestCase('EmptyStr vs EmptyStr --> edit distance = 0', ',,0')]
    procedure TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
  end;
{$ENDREGION}

implementation

{$REGION 'TestLevenshteinDistance'}

procedure TestLevenshteinDistance.Setup;
begin
  FSUT := StringDistanceAlgorithm.Levenshtein;
end;

procedure TestLevenshteinDistance.TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
var
  Result: Integer;
begin
  Result := SUT.Distance(A, B);
  Assert.AreEqual(Expected, Result);
end;

{$ENDREGION}

{$REGION 'TestOptimalStringAlignmentDistance'}

procedure TestOptimalStringAlignmentDistance.Setup;
begin
  FSUT := StringDistanceAlgorithm.OptimalStringAlignment;
end;

procedure TestOptimalStringAlignmentDistance.TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
var
  Result: Integer;
begin
  Result := SUT.Distance(A, B);
  Assert.AreEqual(Expected, Result);
end;

{$ENDREGION}

{$REGION 'TestDamerauLevenshteinDistance'}

procedure TestDamerauLevenshteinDistance.Setup;
begin
  FSUT := StringDistanceAlgorithm.DamerauLevenshtein;
end;

procedure TestDamerauLevenshteinDistance.TestStringDistanceAlgorithm(const A, B: string; const Expected: Integer);
var
  Result: Integer;
begin
  Result := SUT.Distance(A, B);
  Assert.AreEqual(Expected, Result);
end;

{$ENDREGION}

initialization

TDUnitX.RegisterTestFixture(TestLevenshteinDistance);

end.
