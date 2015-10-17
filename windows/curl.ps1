Param(
  [Parameter(Mandatory=$true, Position=0)]
  [String] $Source,

  [Alias("o")]
  [String] $Destination
)

Invoke-WebRequest $Source -OutFile $Destination
