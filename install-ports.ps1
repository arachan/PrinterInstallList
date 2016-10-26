function install-ports{
    Param(
        $port
    )
    Begin{
    }
    Process{
        # Port追加
        Add-Port `
          -PortName $port.Name `
          -HostAddress $port.Name
        <# Windows 8 over
        Add-PrinterPort `
          -Name $port.Name `
          -PrinterHostAddress $port.Name
        #>
    }
}

# 実行
Foreach($arg in $args){
    install-ports -port $arg
    }
