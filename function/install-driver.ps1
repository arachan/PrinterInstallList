# Printer Driver Install Function
function Install-Driver{
    Param(
        # PrinterDriver Name
        $Name,
        # SupportPlatform 'Windows x64' or 'Windows NT x86'
        $SupportPlatform,
        # Version Windows2000 over is 3
        [Int]$Version=3,
        # DriverPath
        $DriverPath,
        # INF File Path Input full Path
        $InfName
    )
    Begin{
        $PrinterDriverList=New-Object System.Management.ManagementClass("Win32_PrinterDriver")
        $PrinterDriver=$PrinterDriverList.CreateInstance()
    }
    Process{
        # プリンタードライバー名
        $PrinterDriver.Name=$Name
        # WIndows x64か Windows NT x86か
        $PrinterDriver.SupportedPlatform=$SupportPlatform
        # version 3 意味は win2k
        $PrinterDriver.Version=$Version
        # ドライバーのフォルダ
        $PrinterDriver.DriverPath=$DriverPath
        # INFファイルのあるパス
        $PrinterDriver.InfName=$InfName
        $PrinterDriverList.AddPrinterDriver($PrinterDriver)
        # Putするのに管理者権限が必要
        $PrinterDriverList.Put()
    }
}