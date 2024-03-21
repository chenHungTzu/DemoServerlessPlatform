:loop
        curl http://localhost:4566/health
        if %errorlevel% neq 0 (
          timeout /t 1
          goto loop
        )
        echo "localstack is ready"