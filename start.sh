#!/bin/bash

python3 -m vllm.entrypoints.openai.api_server 
--model /app/model 
--host 0.0.0.0 
--port 8080 
--dtype float16 
--max-model-len 512 
--gpu-memory-utilization 0.85 
--max-num-seqs 16 
--trust-remote-code
