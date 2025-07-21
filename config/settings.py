# config/settings.py
import os
from dotenv import load_dotenv

# Load .env from project root (run this once)
load_dotenv()

# Now fetch sensitive values from the environment
BOT_TOKEN    = os.getenv('BOT_TOKEN')
LLM_API_URL  = os.getenv('LLM_API_URL')
LLM_API_KEY  = os.getenv('LLM_API_KEY')
DB_URL       = os.getenv('DB_URL')

# Non-sensitive defaults
DATA_DIR     = 'data/html'
