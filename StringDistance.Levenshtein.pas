unit StringDistance.Levenshtein;

interface

uses
  StringDistance,
  System.SysUtils;

type
{$REGION 'TLevenshteinDistance'}
  TLevenshteinDistance = class(TInterfacedObject, IStringDistance)
  strict private
    function Distance(const A, B: string): Integer; inline;
  end;
{$ENDREGION}

implementation

{$REGION 'TLevenshteinDistance'}

function TLevenshteinDistance.Distance(const A, B: string): Integer;
var
  Matrix: StringDistance.Matrix<Integer>;
  LengthA, LengthB, Cost, I, J: Integer;
begin
  LengthA := A.Length;
  LengthB := B.Length;
  Matrix := StringDistance.Matrix.Create<Integer>(LengthA + 1, LengthB + 1);

  for I := 0 to LengthA do
    Matrix[I, 0] := I;

  for I := 0 to LengthB do
    Matrix[0, I] := I;

  for I := 1 to LengthA do
  begin
    for J := 1 to LengthB do
    begin
      if A.Chars[I-1] = B.Chars[J-1] then
        Cost := 0
      else
        Cost := 1;

      Matrix[I, J] := StringDistance.Minimum(Matrix[I-1, J] + 1,
                                             Matrix[I, J-1] + 1,
                                             Matrix[I-1, J-1] + Cost);
    end;
  end;

  Result := Matrix[LengthA, LengthB];
end;

{$ENDREGION}

end.
