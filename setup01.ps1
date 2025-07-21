# setup01.ps1
# Scaffolds the JobSynth project architecture under %devs%\Projects\JobSynth

# 1. Define base path
$basePath = Join-Path $env:devs 'Projects\JobSynth'

# 2. Create root directory
New-Item -ItemType Directory -Path $basePath -Force | Out-Null

# 3. Create subdirectories
$subdirs = @(
    'bot',
    'parser',
    'llm',
    'storage',
    'cli',
    'dashboard',
    'utils',
    'config'
)
foreach ($dir in $subdirs) {
    New-Item -ItemType Directory -Path (Join-Path $basePath $dir) -Force | Out-Null
}

# 4. Define files with placeholder content
$files = @(
    @{ Path    = 'bot\telegram_bot.py'
       Content = '# telegram_bot.py - handles Telegram updates and routing' },
    @{ Path    = 'parser\linkedin_extractor.py'
       Content = '# linkedin_extractor.py - fetch & parse LinkedIn job ads' },
    @{ Path    = 'llm\client.py'
       Content = '# client.py - LLM API integration' },
    @{ Path    = 'storage\yaml_saver.py'
       Content = '# yaml_saver.py - serialize data to YAML' },
    @{ Path    = 'storage\db.py'
       Content = '# db.py - database operations' },
    @{ Path    = 'cli\console.py'
       Content = '# console.py - CLI for inspecting and querying data' },
    @{ Path    = 'dashboard\funnel.py'
       Content = '# funnel.py - data visualization hooks' },
    @{ Path    = 'utils\http.py'
       Content = '# http.py - HTTP helpers with retries' },
    @{ Path    = 'config\settings.py'
       Content = @"
# settings.py - configuration constants

# Telegram
BOT_TOKEN = 'YOUR_TELEGRAM_BOT_TOKEN'

# LLM API
LLM_API_URL = 'https://api.example.com/v1/generate'
LLM_API_KEY = 'YOUR_API_KEY'

# Database
DB_URL = 'postgresql://user:pass@localhost:5432/jobsynth'
"@ },
    @{ Path    = 'requirements.txt'
       Content = @"
python-telegram-bot
requests
PyYAML
psycopg2-binary
"@ },
    @{ Path    = 'README.md'
       Content = "# JobSynth

Project to fetch LinkedIn job ads via Telegram, process with an LLM, and store results in YAML & database." }
)

# 5. Create each file
foreach ($file in $files) {
    $fullPath = Join-Path $basePath $file.Path
    New-Item -ItemType File -Path $fullPath -Force | Out-Null
    Set-Content -Path $fullPath -Value $file.Content -Force
}

# 6. Confirmation
Write-Host "JobSynth scaffold created at $basePath" -ForegroundColor Green
