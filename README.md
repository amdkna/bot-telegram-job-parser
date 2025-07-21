# bot-telegram-job-parser
# JobSynth

A modular Telegram bot pipeline to fetch LinkedIn job ads, process them through an LLM, and store results as YAML files and in a database.

---

## 🚀 Project Overview

**JobSynth** lets you forward a LinkedIn job-ad URL to a Telegram bot. It will:

1. **Extract** the job-ad text from LinkedIn.  
2. **Send** the extracted text to an LLM via API.  
3. **Receive** a structured analysis from the LLM.  
4. **Append** the original ad text to the LLM response.  
5. **Save** the combined payload into a `.yaml` file.  
6. **Persist** selected fields into a PostgreSQL database.  
7. Provide a **CLI** for inspecting saved records.  
8. (Optionally) Expose a **dashboard** or funnel visualization.

The entire pipeline is organized into independent, reusable modules following PEP 8 and clean-architecture principles.

---

## 📁 Directory Structure

```

JobSynth/
├── bot/
│   └── telegram\_bot.py           # Telegram update handlers & routing
├── parser/
│   └── linkedin\_extractor.py     # Fetch & parse LinkedIn job ads
├── llm/
│   └── client.py                 # LLM API client & prompt builder
├── storage/
│   ├── yaml\_saver.py             # Serialize payloads to YAML files
│   └── db.py                     # Database connection & insert operations
├── cli/
│   └── console.py                # CLI for querying and inspecting DB records
├── dashboard/
│   └── funnel.py                 # Hooks for data visualization or web UI
├── utils/
│   └── http.py                   # HTTP helpers with retry logic
├── config/
│   └── settings.py               # Centralized configuration constants
├── requirements.txt              # Python dependencies
└── README.md                     # This file

````

---

## 🔧 Module Summaries

### **bot/telegram_bot.py**  
- Connects to Telegram via `python-telegram-bot`.  
- Listens for messages containing URLs.  
- Delegates to `parser.linkedin_extractor` and orchestrates the workflow.

### **parser/linkedin_extractor.py**  
- Downloads the raw LinkedIn page HTML.  
- Cleans and extracts the job description text.  
- Returns plain text for LLM consumption.

### **llm/client.py**  
- Builds prompts by combining system instructions with the extracted text.  
- Sends requests to your configured LLM endpoint.  
- Handles JSON responses and error cases.

### **storage/yaml_saver.py**  
- Receives a Python dict with “analysis” and “original_text.”  
- Renders it to a `.yaml` file under a timestamped directory.  
- Returns the full path to the saved file.

### **storage/db.py**  
- Uses `psycopg2` (or SQLAlchemy) to connect to PostgreSQL.  
- Defines an `INSERT` routine for key fields (e.g., job title, company, date, LLM summary, file path).  

### **cli/console.py**  
- A simple text-based interface to list, view, and search saved records.  
- Supports filters (date range, company name, keywords).

### **dashboard/funnel.py**  
- (Optional) Reads from the DB and produces charts or dashboards.  
- Integrate with Matplotlib or expose an HTTP endpoint.

### **utils/http.py**  
- Configures a `requests.Session` with retry/backoff.  
- Central logging for HTTP errors.

### **config/settings.py**  
```python
# settings.py – configuration constants

# Telegram
BOT_TOKEN     = 'YOUR_TELEGRAM_BOT_TOKEN'

# LLM API
LLM_API_URL   = 'https://api.example.com/v1/generate'
LLM_API_KEY   = 'YOUR_API_KEY'

# Database
DB_URL        = 'postgresql://user:pass@localhost:5432/jobsynth'
````

---

## ⚙️ Installation & Setup

1. **Clone** the repo and `cd` into it:

   ```bash
   git clone https://github.com/youruser/jobsynth.git
   cd jobsynth
   ```
2. **Install** dependencies:

   ```bash
   python3 -m venv venv
   source venv/bin/activate      # macOS/Linux
   venv\Scripts\activate         # Windows
   pip install -r requirements.txt
   ```
3. **Configure** your credentials in `config/settings.py`.
4. **Initialize** your database (create tables according to `storage/db.py`).
5. **Run** the Telegram bot:

   ```bash
   python bot/telegram_bot.py
   ```

---

## 🏃 Usage

1. **Send** a LinkedIn job-ad URL to your Bot in Telegram.
2. **Wait** for confirmation: you’ll receive the path to the saved YAML.
3. **Inspect** files in `./data/yyyy-mm-dd/` or via the CLI:

   ```bash
   python cli/console.py --list
   python cli/console.py --view <record_id>
   ```

---

## 🤝 Contributing

1. Fork the repo.
2. Create a feature branch (`git checkout -b feature/XYZ`).
3. Commit your changes (`git commit -m "Add XYZ"`).
4. Push (`git push origin feature/XYZ`) and open a Pull Request.
5. Ensure adherence to PEP 8 (`black .`, `flake8`).

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

**Grammar & phrasing suggestion**

> **Original:**
> give me the readme.md with full detail of what I told you and the file details and ...
> **Revised:**
> Please provide a `README.md` with full details of the requirements I described, including file structure and module descriptions.
