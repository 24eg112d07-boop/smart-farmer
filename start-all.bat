@echo off
title Smart Farmer - All-in-One Launcher
echo ========================================================
echo Launching Smart Farmer Marketplace and Rental System
echo ========================================================
echo 1. Launching Spring Boot Backend...
start "Smart Farmer Backend (Spring Boot)" cmd /k "cd /d %~dp0backend && java -jar target\smart-farmer-backend-1.0.0.jar"
echo Waiting 6 seconds for backend initialization...
timeout /t 6 /nobreak >nul
echo 2. Launching React Frontend (Vite)...
start "Smart Farmer Frontend (React Vite)" cmd /k "cd /d %~dp0frontend && npm run dev"
echo ========================================================
echo Both services are now running!
echo Backend URL:  http://localhost:8080
echo Frontend URL: http://localhost:5173
echo ========================================================
pause
