@echo off
set NODE_ENV=development
cd "%~dp0.."
if %errorlevel% neq 0 exit /b %errorlevel%

echo "==> Installing gem dependencies..."
bundle install --path vendor\gems --quiet --without production
if %errorlevel% neq 0 exit /b %errorlevel%

echo "==> Installing npm dependencies..."
npm install
