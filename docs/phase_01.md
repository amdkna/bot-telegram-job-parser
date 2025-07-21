Here’s how to kick off **Step 1**—building the Telegram bot that accepts LinkedIn URLs, fetches the page HTML, and saves it to disk.

---

## 📁 Project Structure (first slice)

```
JobSynth/
├── bot/
│   └── telegram_bot.py        # Telegram handlers & orchestration
├── parser/
│   └── linkedin_extractor.py  # Fetch raw HTML from a URL
├── storage/
│   └── html_saver.py          # Save HTML bytes to a file
├── config/
│   └── settings.py            # Bot token & data-dir path
├── data/
│   └── html/                  # Saved HTML files go here
└── requirements.txt           # python-telegram-bot, requests
```

---

## 📦 Files & Modules

| Path                              | Responsibility                                   |
| --------------------------------- | ------------------------------------------------ |
| **config/settings.py**            | Define `BOT_TOKEN` and `DATA_DIR = 'data/html'`. |
| **parser/linkedin\_extractor.py** | Export `def fetch_html(url: str) -> bytes`:      |

* Validates/normalizes the URL
* Uses `requests.get(...)` to download the page
* Returns raw `response.content` bytes                |
  \| **storage/html\_saver.py**       | Export `def save_html(content: bytes, url: str) -> str`:
* Ensures `DATA_DIR` exists
* Builds a safe filename (e.g. timestamp + slugified hostname/path)
* Writes the bytes to disk
* Returns the full file path                          |
  \| **bot/telegram\_bot.py**         |
* Reads `BOT_TOKEN` from settings
* Uses `python-telegram-bot` to listen for text messages
* On each message:

  1. Extract URL
  2. Call `fetch_html(url)`
  3. Call `save_html(html, url)`
  4. Reply with the saved file (via `update.message.reply_document`)  |
     \| **requirements.txt**            |

```text
python-telegram-bot
requests
```

---

## 🛠️ Step-by-Step Implementation

1. **Register your Bot**

   * Chat with **@BotFather** → `/newbot` → get your `BOT_TOKEN`.

2. **Scaffold directories**

   ```bash
   cd %devs%\Projects\JobSynth
   mkdir bot parser storage config data\data\html
   ```

3. **Create** `config/settings.py`

   ```python
   BOT_TOKEN = 'YOUR_TELEGRAM_BOT_TOKEN'
   DATA_DIR  = 'data/html'
   ```

4. **Implement** `parser/linkedin_extractor.py`

   ```python
   import requests

   def fetch_html(url: str) -> bytes:
       if not url.startswith(('http://', 'https://')):
           url = 'https://' + url
       resp = requests.get(url, timeout=10)
       resp.raise_for_status()
       return resp.content
   ```

5. **Implement** `storage/html_saver.py`

   ```python
   import os
   import hashlib
   import datetime
   from config.settings import DATA_DIR

   def save_html(content: bytes, url: str) -> str:
       os.makedirs(DATA_DIR, exist_ok=True)
       # create a short hash of the URL to avoid invalid chars
       url_hash = hashlib.sha1(url.encode()).hexdigest()[:8]
       ts = datetime.datetime.utcnow().strftime('%Y%m%dT%H%M%SZ')
       filename = f"{ts}_{url_hash}.html"
       path = os.path.join(DATA_DIR, filename)
       with open(path, 'wb') as f:
           f.write(content)
       return path
   ```

6. **Implement** `bot/telegram_bot.py`

   ```python
   from telegram import Update
   from telegram.ext import Updater, MessageHandler, Filters, CallbackContext
   from config.settings import BOT_TOKEN
   from parser.linkedin_extractor import fetch_html
   from storage.html_saver      import save_html

   def handle_message(update: Update, ctx: CallbackContext):
       url = update.message.text.strip()
       try:
           html = fetch_html(url)
           filepath = save_html(html, url)
           update.message.reply_document(
               document=open(filepath, 'rb'),
               caption=f"Saved HTML → {filepath}"
           )
       except Exception as e:
           update.message.reply_text(f"Error: {e}")

   def main():
       updater = Updater(BOT_TOKEN)
       dp = updater.dispatcher
       dp.add_handler(MessageHandler(Filters.text & ~Filters.command, handle_message))
       updater.start_polling()
       updater.idle()

   if __name__ == '__main__':
       main()
   ```

7. **Declare** `requirements.txt`

   ```text
   python-telegram-bot
   requests
   ```

8. **Install** & **Run**

   ```bash
   pip install -r requirements.txt
   python bot/telegram_bot.py
   ```

   Then, in Telegram, send a LinkedIn job-ad URL to your bot and watch it save the HTML under `data/html/`.

---

**Grammar & phrasing suggestion**

> **Original:**
> first step: lets create the telegram bot to receive linkedin links and parse the HTML and save to a file. what are the files and modules name? what are their functionality what are the steps I need to do. give me a full instruction
>
> **Revised:**
> First, let’s create the Telegram bot that receives LinkedIn links, parses the HTML, and saves it to a file. What are the file and module names? What are their functionalities? What steps do I need to take? Please provide full instructions.
