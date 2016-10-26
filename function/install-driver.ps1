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
        # Printer Driver Name プリンタードライバー名
        $PrinterDriver.Name=$Name
        # WIndows x64 or Windows NT x86
        $PrinterDriver.SupportedPlatform=$SupportPlatform
        # version 3  win2k over is version 3
        $PrinterDriver.Version=$Version
        # Driver Folder ドライバーのフォルダ
        $PrinterDriver.DriverPath=$DriverPath
        # Inf File Path INFファイルのあるパス
        $PrinterDriver.InfName=$InfName
        $PrinterDriverList.AddPrinterDriver($PrinterDriver)
        # Need Admin Right Putするのに管理者権限が必要
        $PrinterDriverList.Put()
    }
}
