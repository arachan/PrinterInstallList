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
        # Printer Driver プリンタードライバー
        $Printer.DriverName=$DriverName
        # Port Name ポート名
        $ Printer.PortName=$PortName
        # Printer Location 場所の記述
        $Printer.Location=$Location
        # Comment コメント
        $Printer.Comment=$Comment
        # Device Name ディバイス名
        $Printer.DeviceID=$Name
        # Printer registration プリンター登録
        $Printer.Put()
    }
}
