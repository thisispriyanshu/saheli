import os
from typing import List
import google.generativeai as genai
from sentence_transformers import SentenceTransformer
import faiss
import numpy as np
import torch
from dotenv import load_dotenv
from watchdog.events import FileSystemEventHandler, FileCreatedEvent, FileModifiedEvent, FileDeletedEvent

# Load environment variables
load_dotenv()

class RAGChatbot:
    def __init__(self):
        # Initialize Gemini
        api_key = os.getenv('GOOGLE_API_KEY')
        if not api_key:
            raise ValueError("GOOGLE_API_KEY not found in environment variables")
        
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel('gemini-pro')
        
        # Initialize sentence transformer
        self.encoder = SentenceTransformer('all-MiniLM-L6-v2')
        
        # Initialize FAISS index
        self.dimension = 384  # Dimension of embeddings from all-MiniLM-L6-v2
        self.index = faiss.IndexFlatL2(self.dimension)
        
        # Load and index documents
        self.documents = self.load_documents()
        self.index_documents()

    def load_documents(self) -> List[str]:
        documents = []
        data_dir = 'data'
        
        for filename in os.listdir(data_dir):
            if filename.endswith('.txt'):
                with open(os.path.join(data_dir, filename), 'r', encoding='utf-8') as f:
                    text = f.read()
                    # Split into chunks (simple approach - you might want to use a more sophisticated chunking strategy)
                    chunks = [text[i:i+512] for i in range(0, len(text), 512)]
                    documents.extend(chunks)
        
        return documents

    def index_documents(self):
        # Create embeddings for all documents
        embeddings = self.encoder.encode(self.documents)
        self.index.add(np.array(embeddings).astype('float32'))

    def get_relevant_context(self, query: str, k: int = 3) -> str:
        # Get query embedding
        query_embedding = self.encoder.encode([query])[0]
        
        # Search for similar documents
        distances, indices = self.index.search(
            np.array([query_embedding]).astype('float32'), k
        )
        
        # Combine relevant documents
        relevant_docs = [self.documents[i] for i in indices[0]]
        return "\n".join(relevant_docs)

    def get_response(self, query: str) -> str:
        # Get relevant context
        context = self.get_relevant_context(query)
        
        # Create prompt
        prompt = f"""Context: {context}

Question: {query}

Please provide a response based on the context above. If the context doesn't contain relevant information, 
please indicate that and provide a general response."""

        # Get response from Gemini
        response = self.model.generate_content(prompt)
        return response.text
