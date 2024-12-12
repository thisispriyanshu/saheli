import os
from typing import List
import google.generativeai as genai
from sentence_transformers import SentenceTransformer
import faiss
import numpy as np
from dotenv import load_dotenv
import gc  # for garbage collection

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
        
        # Use a smaller, more efficient model
        self.encoder = SentenceTransformer('paraphrase-MiniLM-L3-v2')  # smaller model
        
        # Initialize FAISS index with a more memory-efficient index type
        self.dimension = 384
        self.index = faiss.IndexFlatIP(self.dimension)  # Using inner product instead of L2
        
        # Load and index documents
        self.documents = self.load_documents()
        self.index_documents()
        
        # Clear any unused memory
        gc.collect()

    def load_documents(self) -> List[str]:
        documents = []
        data_dir = 'data'
        
        for filename in os.listdir(data_dir):
            if filename.endswith('.txt'):
                with open(os.path.join(data_dir, filename), 'r', encoding='utf-8') as f:
                    text = f.read()
                    # Increase chunk size to reduce number of embeddings
                    chunks = [text[i:i+1024] for i in range(0, len(text), 1024)]
                    documents.extend(chunks)
        
        return documents

    def index_documents(self):
        # Process documents in smaller batches to manage memory
        batch_size = 32
        for i in range(0, len(self.documents), batch_size):
            batch = self.documents[i:i+batch_size]
            embeddings = self.encoder.encode(batch)
            self.index.add(np.array(embeddings).astype('float32'))
            gc.collect()  # Clear memory after each batch

    def get_relevant_context(self, query: str, k: int = 2) -> str:  # Reduced k from 3 to 2
        query_embedding = self.encoder.encode([query])[0]
        distances, indices = self.index.search(
            np.array([query_embedding]).astype('float32'), k
        )
        relevant_docs = [self.documents[i] for i in indices[0]]
        return "\n".join(relevant_docs)

    def get_response(self, query: str) -> str:
        context = self.get_relevant_context(query)
        prompt = f"""Context: {context}

Question: {query}

Please provide a concise response based on the context above."""  # Modified prompt to encourage shorter responses

        response = self.model.generate_content(prompt)
        gc.collect()  # Clear memory after generating response
        return response.text
