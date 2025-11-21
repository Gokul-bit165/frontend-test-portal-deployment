# Quick Deployment Script for Git Push
# Run this script to prepare your code for deployment

Write-Host "🚀 Preparing for deployment..." -ForegroundColor Cyan

# Navigate to project directory
Set-Location -Path "c:\Users\gokul\frontend-test-deployment\frontend-test-portal"

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "📦 Initializing Git repository..." -ForegroundColor Yellow
    git init
    git branch -M main
}

# Check for changes
$status = git status --porcelain
if ($status) {
    Write-Host "📝 Adding changes..." -ForegroundColor Green
    git add .
    
    $commitMsg = Read-Host "Enter commit message (or press Enter for default)"
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $commitMsg = "Deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    }
    
    git commit -m $commitMsg
    Write-Host "✅ Changes committed!" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No changes to commit" -ForegroundColor Gray
}

# Check if remote exists
$remotes = git remote
if ($remotes -notcontains "origin") {
    Write-Host ""
    Write-Host "⚠️  No remote repository configured!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Create a new repository on GitHub" -ForegroundColor White
    Write-Host "2. Run: git remote add origin https://github.com/YOUR_USERNAME/test-portal.git" -ForegroundColor White
    Write-Host "3. Run: git push -u origin main" -ForegroundColor White
} else {
    $push = Read-Host "`nPush to remote? (y/n)"
    if ($push -eq "y") {
        Write-Host "⬆️  Pushing to remote..." -ForegroundColor Cyan
        git push
        Write-Host "✅ Pushed successfully!" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "🎉 Ready for deployment!" -ForegroundColor Green
Write-Host ""
Write-Host "Deployment options:" -ForegroundColor Cyan
Write-Host "1. Render.com (Recommended) - Read DEPLOYMENT.md" -ForegroundColor White
Write-Host "2. Railway.app - Read DEPLOYMENT.md" -ForegroundColor White
Write-Host "3. Netlify + Render - Read DEPLOYMENT.md" -ForegroundColor White
