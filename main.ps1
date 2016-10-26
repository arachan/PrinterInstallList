<#
.Synopsis
    支店と部署からプリンタードライバーをインストールする
    遠隔処理版
.DESCRIPTION
    1. driverlist.csvからその支店の部署にあったプリンタードライバーをインストール
    2. printer_place.csvからその支店の部署にあったプリンターのインストールを行う。

.EXAMPLE


.NOTES

    Author: Yusuke Arakawa 2016/10/20
#>

# Create Session  Sessionの作成
$s=New-PSSession -ComputerName PC_Name -Credential Workgroup\user

# Join-ObjectをImport
. .\Function\Join-Object.ps1

# printer_place.csvから該当するプリンターとポートを取得
# 条件は支店と部署
$place=Import-Csv .\PrinterPlace.csv
$place=$place `
 | Where-Object {$_.Branch -match 'Main'} `
 | Where-Object {$_.Section -match 'sales'}

# 取得したドライバー名からドライバーを取得
$driverlist=Import-Csv -Path .\DriverList.csv

# 必要なDriverを抽出
## Join-Objectを使ってプリンタードライバーの一覧から該当する支店と部署のプリンタードライバーを抽出する。
## SQLのようにDriver_NameでInner Joinし、TypeをOnlyInBoth にしている。
$driverlist = `
Join-Object `
-Left $driverlist `
-LeftJoinProperty `
Name -Right $place `
-RightJoinProperty Driver_Name `
-Type OnlyIfInBoth `
| Select `
ID,Arch,Name,Path,INF,Platform

# Portだけを抽出
$ports=$place | Group PrinterPort | Select Name

# Read Functions into Remote Session
Invoke-Command -Session $s -FilePath .\function\add-port.ps1
Invoke-Command -Session $s -FilePath .\function\install-driver.ps1
Invoke-Command -Session $s -FilePath .\function\create-printer.ps1

# Printer Driver Install
Invoke-Command -Session $s -FilePath .\install-drivers.ps1 -ArgumentList $driverlist
# Make Printer Port
Invoke-Command -Session $s -FilePath .\install-ports.ps1 -ArgumentList $ports
# Printer Install
Invoke-Command -Session $s -FilePath .\install-printers.ps1 -ArgumentList $place
