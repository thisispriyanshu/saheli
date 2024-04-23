from pydantic import BaseModel
from fastapi import FastAPI
import helper

app = FastAPI()

class Query(BaseModel):
    query: str

async def search(query):
    result = await helper.return_query(query.query)
    return result

@app.post("/chat")
async def chat(query: Query):
    result = await search(query)  # Use await for async function
    return {
        "response": result
        }
