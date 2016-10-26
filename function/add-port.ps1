function Add-Port{
    Param(
        # Printer Port Name ポート名
        [string]$PortName,
        # Printer Host IP Address プリンターのIPアドレス
        [string]$HostAddress
    )
    Begin{
       $PortList=New-Object System.Management.ManagementClass("Win32_TcpIpPrinterPort")
       $Port=$PortList.CreateInstance()
    }
    Process{
        # Port Name
        $Port.Name=$PortName
        # RAW mode: 1 LPR: 2
        $Port.Protocol=1
        # Printer IP Address
        $Port.HostAddress=$HostAddress
        # Port Number RAW　9100
        $Port.PortNumber='9100'
        # SNMPをonにするかしないか
        $Port.SnmpEnabled=$true
        # Add PrinterPort
        $Port.Put()
    }
}
