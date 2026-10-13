@echo off
title Smart Farmer Backend Server
echo ===================================================
echo Starting Smart Farmer Marketplace Backend (Spring Boot)
echo ===================================================
cd /d "%~dp0backend"
java -jar target\smart-farmer-backend-1.0.0.jar
pause
