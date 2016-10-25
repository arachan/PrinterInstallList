net use z: \\IPAddress\PrinterDriver

function install-drivers{
    Param(
        $driver
    )
    Begin{
    }
    Process{        
        # 同じPROCESSOR_ARCHITECTUREの時だけプリンタードライバーをインストール
        if($driver.Arch -match (Get-Item Env:\PROCESSOR_ARCHITECTURE).Value){
            echo $driver.Arch
            $driver.INF=$driver.Path+'\'+$driver.INF
            $driver.Path
            Install-Driver -Name $driver.Name -SupportPlatform $driver.Platform -Path $driver.Path -INF $driver.INF
        }
        else{
            echo "Archが違うので実行しませんよ"
        }
    }
}

# 実行
foreach($arg in $args){
    install-drivers -driver $arg
}