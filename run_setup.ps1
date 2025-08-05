# Tenkasi DIC - PowerShell Auto Setup Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Tenkasi DIC - Auto Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if service is running
function Test-ServiceRunning {
    param($ServiceName, $Port)
    
    try {
        $connection = Test-NetConnection -ComputerName localhost -Port $Port -WarningAction SilentlyContinue
        return $connection.TcpTestSucceeded
    }
    catch {
        return $false
    }
}

# Function to start XAMPP services
function Start-XAMPP {
    Write-Host "[1/6] Checking XAMPP installation..." -ForegroundColor Yellow
    
    if (Test-Path "C:\xampp\xampp-control.exe") {
        Write-Host "✅ XAMPP found at C:\xampp\" -ForegroundColor Green
    } else {
        Write-Host "❌ XAMPP not found at C:\xampp\" -ForegroundColor Red
        Write-Host "Please install XAMPP from: https://www.apachefriends.org/" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    
    Write-Host ""
    Write-Host "[2/6] Checking project files..." -ForegroundColor Yellow
    
    if (Test-Path "C:\xampp\htdocs\TenkasiDIC--FrontEnd\") {
        Write-Host "✅ Project found in htdocs" -ForegroundColor Green
    } else {
        Write-Host "❌ Project not found in htdocs" -ForegroundColor Red
        Write-Host "Please copy your project to: C:\xampp\htdocs\TenkasiDIC--FrontEnd\" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    
    Write-Host ""
    Write-Host "[3/6] Starting XAMPP services..." -ForegroundColor Yellow
    
    # Start XAMPP Control Panel
    Start-Process "C:\xampp\xampp-control.exe" -WindowStyle Minimized
    
    Write-Host "Waiting for services to start..." -ForegroundColor Yellow
    Start-Sleep -Seconds 15
    
    Write-Host ""
    Write-Host "[4/6] Checking Apache service..." -ForegroundColor Yellow
    
    if (Test-ServiceRunning -ServiceName "Apache" -Port 80) {
        Write-Host "✅ Apache is running on port 80" -ForegroundColor Green
    } else {
        Write-Host "❌ Apache is not running" -ForegroundColor Red
        Write-Host "Please start Apache manually in XAMPP Control Panel" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    
    Write-Host ""
    Write-Host "[5/6] Checking MySQL service..." -ForegroundColor Yellow
    
    if (Test-ServiceRunning -ServiceName "MySQL" -Port 3306) {
        Write-Host "✅ MySQL is running on port 3306" -ForegroundColor Green
    } else {
        Write-Host "❌ MySQL is not running" -ForegroundColor Red
        Write-Host "Please start MySQL manually in XAMPP Control Panel" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    
    Write-Host ""
    Write-Host "[6/6] Opening setup page..." -ForegroundColor Yellow
    Write-Host "✅ All services are running!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Opening setup page in browser..." -ForegroundColor Yellow
    
    # Open setup page
    Start-Process "http://localhost/TenkasiDIC--FrontEnd/admin/setup.php"
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Setup Complete!" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Complete the setup in your browser" -ForegroundColor White
    Write-Host "2. Access admin panel: http://localhost/TenkasiDIC--FrontEnd/admin/" -ForegroundColor White
    Write-Host "3. Upload your documents" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Press 'A' to open admin panel, or any other key to exit"
    if ($choice -eq "A" -or $choice -eq "a") {
        Start-Process "http://localhost/TenkasiDIC--FrontEnd/admin/"
        Write-Host ""
        Write-Host "Admin panel opened! You can now:" -ForegroundColor Green
        Write-Host "- Upload documents" -ForegroundColor White
        Write-Host "- Manage existing documents" -ForegroundColor White
        Write-Host "- View statistics" -ForegroundColor White
    }
    
    Write-Host ""
    Read-Host "Press Enter to exit"
}

# Function to test PHP functionality
function Test-PHPFunctionality {
    Write-Host "Testing PHP functionality..." -ForegroundColor Yellow
    
    $testUrl = "http://localhost/TenkasiDIC--FrontEnd/admin/setup.php"
    
    try {
        $response = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 10
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ PHP is working correctly" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ PHP returned status code: $($response.StatusCode)" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ Error testing PHP: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Function to check database connection
function Test-DatabaseConnection {
    Write-Host "Testing database connection..." -ForegroundColor Yellow
    
    $testUrl = "http://localhost/TenkasiDIC--FrontEnd/admin/api/dashboard.php"
    
    try {
        $response = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 10
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ Database connection successful" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ Database connection failed" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ Error testing database: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Main execution
try {
    Start-XAMPP
    
    Write-Host ""
    Write-Host "Running additional tests..." -ForegroundColor Yellow
    
    if (Test-PHPFunctionality) {
        if (Test-DatabaseConnection) {
            Write-Host ""
            Write-Host "🎉 All systems are working correctly!" -ForegroundColor Green
            Write-Host "Your Tenkasi DIC admin panel is ready to use." -ForegroundColor Green
        }
    }
}
catch {
    Write-Host "❌ Error during setup: $($_.Exception.Message)" -ForegroundColor Red
}

Read-Host "Press Enter to exit" 