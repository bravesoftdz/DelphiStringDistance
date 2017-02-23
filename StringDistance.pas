unit StringDistance;

interface

uses
  System.Math,
  System.Generics.Collections;

type
  /// <summary> Provee metodos estaticos para trabajar con arreglos dinamicos </summary>
  TArray = class(System.Generics.Collections.TArray)
  public
    /// <summary> Crea un arreglo dinamico de tamaño N vacio </summary>
    class function Create<T>(const N: Integer): TArray<T>; static; inline;
    /// <summary> Crea un arreglo dinamico de tamaño N, y en cada posicion coloca Value </summary>
    class function Fill<T>(const Value: T; const N: Integer): TArray<T>; static; inline;
  end;

  /// <summary> Matriz dinamica generica </summary>
  Matrix<T> = array of array of T;

  /// <summary> Provee metodos estaticos para trabajar con matrices dinamicas </summary>
  Matrix = record
  public
    /// <summary> Crea una matriz de tamaño NxM vacia </summary>
    class function Create<T>(const N, M: Integer): Matrix<T>; static; inline;
    /// <summary> Crea una matriz de tamaño NxM y en cada posicion coloca Value </summary>
    class function Fill<T>(const Value: T; const N, M: Integer): Matrix<T>; static; inline;
  end;

{$REGION 'IStringDistance'}
  /// <summary> Calcula la distancia entre dos string </summary>
  IStringDistance = interface
    ['{2D3C5367-4921-48ED-AF09-FB799B55C1AB}']
    function Distance(const A, B: string): Integer;
  end;
{$ENDREGION}

{$REGION 'StringDistanceAlgorithm'}
  /// <summary> Fabrica de algoritmos de comparacion de strings </summary>
  StringDistanceAlgorithm = record
  public
    /// <summary> Devuelve una implementacion del algoritmo de distancia de Levenshtein </summary>
    class function Levenshtein: IStringDistance; static;
    /// <summary> Devuelve una implementacion del algoritmo de distancia de Damerau-Levenshtein </summary>
    class function DamerauLevenshtein: IStringDistance; static;
    /// <summary> Devuelve una implementacion del algoritmo de distancia de alineamiento de cadenas optimo (OSA) </summary>
    class function OptimalStringAlignment: IStringDistance; static;
  end;
{$ENDREGION}

/// <summary> Devuelve el minimo de entre dos enteros </summary>
function Minimum(const A, B: Integer): Integer; overload; inline;
/// <summary> Devuelve el minimo de entre tres enteros </summary>
function Minimum(const A, B, C: Integer): Integer; overload; inline;
/// <summary> Devuelve el minimo de entre cuatro enteros </summary>
function Minimum(const A, B, C, D: Integer): Integer; overload; inline;

implementation

uses
  StringDistance.OptimalStringAlignment,
  StringDistance.Levenshtein,
  StringDistance.DamerauLevenshtein;

{$REGION 'StringDistanceAlgorithm'}

class function StringDistanceAlgorithm.Levenshtein: IStringDistance;
begin
  Result := TLevenshteinDistance.Create;
end;

class function StringDistanceAlgorithm.DamerauLevenshtein: IStringDistance;
begin
  Result := TDamerauLevenshteinDistance.Create;
end;

class function StringDistanceAlgorithm.OptimalStringAlignment: IStringDistance;
begin
  Result := TOptimalStringAlignment.Create;
end;

{$ENDREGION}

{$REGION 'TArray'}

class function TArray.Create<T>(const N: Integer): TArray<T>;
begin
  System.SetLength(Result, N);
end;

class function TArray.Fill<T>(const Value: T; const N: Integer): TArray<T>;
var
  I: Integer;
begin
  Result := TArray.Create<T>(N);
  for I := System.Low(Result) to System.High(Result) do
    Result[I] := Value;
end;

{$ENDREGION}

{$REGION 'Matrix'}

class function Matrix.Create<T>(const N, M: Integer): Matrix<T>;
var
  I: Integer;
begin
  System.SetLength(Result, N);
  for I := 0 to System.High(Result) do
    Result[I] := TArray.Create<T>(M);
end;

class function Matrix.Fill<T>(const Value: T; const N, M: Integer): Matrix<T>;
var
  I: Integer;
begin
  Result := Matrix.Create<T>(N, M);
  for I := 0 to N - 1 do
    Result[I] := TArray.Fill(Value, M);
end;

{$ENDREGION}

function Minimum(const A, B: Integer): Integer;
begin
  Result := System.Math.Min(A, B);
end;

function Minimum(const A, B, C: Integer): Integer;
begin
  Result := System.Math.Min(A, System.Math.Min(B, C));
end;

function Minimum(const A, B, C, D: Integer): Integer;
begin
  Result := System.Math.Min(Minimum(A, B, C), D);
end;

end.
