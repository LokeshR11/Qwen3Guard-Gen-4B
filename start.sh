#!/bin/bash

set -e

echo "Starting Qwen3Guard-Gen-4B..."

exec python3 -m vllm.entrypoints.openai.api_server 
--model /app/model 
--host 0.0.0.0 
--port 8080 
--dtype float16 
--max-model-len 512 
--gpu-memory-utilization 0.85 
--trust-remote-code
