#!/bin/bash

set -e

echo "Python Version:"
python --version

echo "Transformers Version:"
python -c "import transformers; print(transformers.**version**)"

echo "Starting Qwen3Guard-Gen-4B..."

exec python -m vllm.entrypoints.openai.api_server 
--model /app/model 
--host 0.0.0.0 
--port 8080 
--dtype float16 
--gpu-memory-utilization 0.85 
--max-model-len 512 
--trust-remote-code
