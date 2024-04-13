from pydantic import BaseModel
from fastapi import FastAPI
import helper



app = FastAPI()

def search(query):
    result=helper.return_query(query.query)
    return result.response

class Query(BaseModel):
    query:str

@app.post("/chat")
async def chat(query: Query):
        result = search(query)
        return result