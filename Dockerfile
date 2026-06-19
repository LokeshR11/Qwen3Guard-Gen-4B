# =====================================================
# Builder Stage
# =====================================================
FROM python:3.10-slim AS builder

WORKDIR /builder

RUN pip install --no-cache-dir "huggingface_hub[hf_xet]"

ENV HF_HOME=/tmp/hf
ENV HF_HUB_ENABLE_HF_TRANSFER=1

RUN python3 -c "from huggingface_hub import snapshot_download; snapshot_download(repo_id='Qwen/Qwen3Guard-Gen-4B', local_dir='/model', local_dir_use_symlinks=False, ignore_patterns=['*.md','*.txt','.gitattributes'])"

RUN rm -rf /tmp/hf
RUN rm -rf /root/.cache
RUN rm -rf /tmp/*

# =====================================================
# Runtime Stage
# =====================================================
FROM vllm/vllm-openai:v0.9.1

WORKDIR /app

COPY --from=builder /model /app/model

COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh


RUN chmod -R 755 /app/model


RUN mkdir -p /cache/hf && chmod -R 777 /cache

ENV HF_HOME=/cache/hf
ENV TRANSFORMERS_CACHE=/cache/hf

ENV VLLM_USE_V1=0

EXPOSE 8080

ENTRYPOINT []

CMD ["/bin/bash", "/app/start.sh"]
