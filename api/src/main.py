from fastapi import FastAPI

app = FastAPI()

@app.get("ping", response_model=str)
async def ping():
    return "pong"