function install-printers{
    Param(
        $place
    )
    Begin{
    }
    Process{
        # Printer追加
        create-printer -Name $place.Printer_Name -DriverName $place.Driver_Name -PortName $place.PrinterPort -Location $place.Location -Comment $place.Comment
        # Windows 8 over
        # Add-Printer -Name $place.Printer_Name -DriverName $place.Driver_Name -PortName $place.PrinterPort -Location $place.Location -Comment $place.Comment
    }
}

# 実行
Foreach($arg in $args){
    install-printers -place $arg
    }
