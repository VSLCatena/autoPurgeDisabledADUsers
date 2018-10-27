$Bases = @("OU=EXAMPLE,DC=company, DC=local","OU=EXAMPLE,DC=company, DC=local")

$Range = Read-Host -Prompt 'Range in days'

foreach ($Base in $Bases) {
	$userBase=Search-ADAccount -UsersOnly -SearchBase $Base -AccountInactive -TimeSpan $Range | ?{$_.enabled -eq $false} | Get-ADUser -Properties Name, sAMAccountName  | Select Name, sAMAccountName
	Write-Host $Base, ":", $userBase.Count
	$Users+=$userBase


}


foreach ($User in $Users) {

$Folder = "F:\Homes\"+$User.sAMAccountName

if(Test-Path -Path $Folder ){
Write-Host $User.name, $Folder 
"{0:N2} MB" -f ((Get-ChildItem  $Folder -Recurse | Measure-Object -Property Length -Sum ).Sum / 1MB) 
}
}
