FROM vllm/vllm-openai:v0.9.1

WORKDIR /app

RUN pip install --no-cache-dir --upgrade \
    transformers \
    tokenizers \
    accelerate

COPY --from=builder /model /app/model

ENV HF_HOME=/app/model
ENV TRANSFORMERS_CACHE=/app/model

COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh

EXPOSE 8080

ENTRYPOINT []

CMD ["/bin/bash", "/app/start.sh"]
