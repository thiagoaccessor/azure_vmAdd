# Definir suas credenciais do Azure
$subscriptionId = "SUBSCRIPTION_ID"
$tenantId = "TENANT_ID"
$clientSecret = "CLIENT_SECRET"
$clientID = "CLIENT_ID"
$location = "LOCATION"

# Login no Azure
$secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($clientID, $secureSecret)
Connect-AzAccount -ServicePrincipal -TenantId $tenantId -Credential $credential | Out-Null
Select-AzSubscription -SubscriptionId $subscriptionId

# Definir os detalhes da VM
$imageURN = "IMAGE_URN" # Exemplo: MicrosoftWindowsServer:WindowsServer:2019-datacenter:latest
$vmSize = "VM_SIZE" # Exemplo: Standard_D2_v3
$vmCount = "VM_COUNT"
$vmNamePrefix = "VM_NAME_PREFIX"

# Criar as VMs
for($i = 1; $i -le $vmCount; $i++) {
    $vmName = $vmNamePrefix + $i.ToString().PadLeft(2, "0")
    New-AzVm `
        -ResourceGroupName "RESOURCE_GROUP_NAME" `
        -Name $vmName `
        -Image $imageURN `
        -Location $location `
        -Size $vmSize `
        -Verbose `
        -OpenPorts 80, 443
}

# Desconectar do Azure
Disconnect-AzAccount
