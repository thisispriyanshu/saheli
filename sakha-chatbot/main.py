from flask import Flask, request, jsonify
from helper import RAGChatbot
import os

app = Flask(__name__)
chatbot = RAGChatbot()

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        user_message = data.get('message')
        if not user_message:
            return jsonify({'error': 'No message provided'}), 400
        
        response = chatbot.get_response(user_message)
        return jsonify({'response': response})
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # Get port from environment variable or default to 8080
    port = int(os.environ.get('PORT', 8080))
    # Run the app, binding to all available interfaces (0.0.0.0)
    app.run(host='0.0.0.0', port=port)
