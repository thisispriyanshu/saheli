from llama_index.llms.gemini import Gemini
import google.generativeai as genai
from llama_index.core import SimpleDirectoryReader
from llama_index.core import VectorStoreIndex
from IPython.display import Markdown, display
from llama_index.core import ServiceContext
from llama_index.core import StorageContext, load_index_from_storage
from llama_index.embeddings.gemini import GeminiEmbedding

# Load the API key from the .env file
import os
from dotenv import load_dotenv
load_dotenv()
google_api_key=os.getenv("GOOGLE_API_KEY")

# Configure the API key
genai.configure(api_key=google_api_key)

# Load the documents
documents=SimpleDirectoryReader("./data")
doc=documents.load_data()

# Create a Gemini instance
model=Gemini(models='gemini-pro',api_key=google_api_key)

# Create a GeminiEmbedding instance
gemini_embed_model=GeminiEmbedding(model_name="models/embedding-001")

# Create a VectorStoreIndex instance
# Configure Service Context
service_context = ServiceContext.from_defaults(llm=model,embed_model=gemini_embed_model, chunk_size=800, chunk_overlap=20)

# Configure Storage Context
index = VectorStoreIndex.from_documents(doc,service_context=service_context)

# Save the index
index.storage_context.persist()

# Load the index
query_engine=index.as_query_engine()

# define a function to return query_engine
def return_query(query):
    return query_engine.query(query)