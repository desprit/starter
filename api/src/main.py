from fastapi import FastAPI

app = FastAPI()

@app.get("/api/v1/ping", response_model=str)
async def ping():
    return "pong"