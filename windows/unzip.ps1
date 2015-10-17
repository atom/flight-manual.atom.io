Param(
  [Parameter(Mandatory=$true, Position=0)]
  [String] $ZipFileName
)

Expand-Archive $ZipFileName .
