unit StringDistance.DamerauLevenshtein;

interface

uses
  StringDistance,
  System.SysUtils;

type
{$REGION 'TDamerauLevenshteinDistance'}
  TDamerauLevenshteinDistance = class(TInterfacedObject, IStringDistance)
  strict private
    function Distance(const A, B: string): Integer; inline;
  end;
{$ENDREGION}

implementation

uses
  System.Character;

{$REGION 'TDamerauLevenshteinDistance'}

function TDamerauLevenshteinDistance.Distance(const A, B: string): Integer;
var
  Matrix: StringDistance.Matrix<Integer>;
  Dictionary: array [Char] of Integer;
  LengthA, LengthB, MaxDistance, Cost, DB, I, K, J, L: Integer;
  C: Char;
begin
  LengthA := A.Length;
  LengthB := B.Length;

  if LengthA = 0 then
    Exit(LengthB);

  if LengthB = 0 then
    Exit(LengthA);

  MaxDistance := LengthA + LengthB;
  Matrix := StringDistance.Matrix.Create<Integer>(LengthA + 1, LengthB + 1);

  for I := 0 to LengthA do
  begin
    Matrix[I, 0] := MaxDistance;
    Matrix[I, 1] := I;
  end;

  for I := 0 to LengthB do
  begin
    Matrix[0, I] := MaxDistance;
    Matrix[1, I] := I;
  end;

  for C := System.Low(System.Char) to System.High(System.Char) do
    Dictionary[C] := 0;

  for I := 1 to LengthA do
  begin
    DB := 0;
    for J := 1 to LengthB do
    begin
      K := Dictionary[B.Chars[J-1].ToLower];
      L := DB;

      if A.Chars[I-1] = B.Chars[J-1] then
      begin
        Cost := 0;
        DB := J;
      end
      else
        Cost := 1;

      Matrix[I, J] := StringDistance.Minimum(Matrix[I-1, J-1] + Cost,
                                             Matrix[I, J-1] + 1,
                                             Matrix[I-1, J] + 1,
                                             Matrix[K, L] + (I-K-1) + 1 + (J-L-1));

      Dictionary[A.Chars[I-1].ToLower] := I;
    end;
  end;

  Result := Matrix[LengthA, LengthB];
end;

{$ENDREGION}

end.
