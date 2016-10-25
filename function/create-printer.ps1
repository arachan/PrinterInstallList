function create-printer{
    Param(
        # Printer Name プリンター名
        $Name,
        # Printer Driver Name プリンタードライバー名
        $DriverName,
        # PortName ポート名
        $PortName,
        # Location 場所
        $Location,
        # Comment コメント
        $Comment
    )

    Begin{
        $PrinterList=New-Object System.Management.ManagementClass("Win32_Printer")
        $Printer=$PrinterList.CreateInstance()
    }

    Process{
        # プリンタードライバー
        $Printer.DriverName=$DriverName
        # ポート名
        $Printer.PortName=$PortName
        # 場所の記述
        $Printer.Location=$Location
        # コメント
        $Printer.Comment=$Comment
        # ディバイス名
        $Printer.DeviceID=$Name
        # プリンター登録
        $Printer.Put()
    }
}