function Add-Port{
    Param(
        # PortName ポート名
        [string]$PortName,
        # HostAddress プリンターのIPアドレス
        [string]$HostAddress
    )
    Begin{
       $PortList=New-Object System.Management.ManagementClass("Win32_TcpIpPrinterPort")
       $Port=$PortList.CreateInstance()
    }
    Process{
        # Port名
        $Port.Name=$PortName
        # RAWモード: 1 LPR: 2
        $Port.Protocol=1
        # PortのIPアドレス
        $Port.HostAddress=$HostAddress
        # Port番号 RAWモードなので9100   
        $Port.PortNumber='9100'
        # SNMPをonにするかしないか  
        $Port.SnmpEnabled=$true
        # PrinterPort追加
        $Port.Put()
    }
}
