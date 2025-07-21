Here’s how to link your existing `JobSynth` folder to your GitHub repo (`bot-telegram-job-parser`) from PowerShell:

1. **Open PowerShell** and navigate to your project:

   ```powershell
   cd $env:devs\Projects\JobSynth
   ```

2. **Initialize Git** (if you haven’t already):

   ```powershell
   git init
   ```

3. **Ensure you’re on `main`**:

   ```powershell
   git branch -M main
   ```

4. **Add the remote**:

   ```powershell
   git remote add origin https://github.com/amdkna/bot-telegram-job-parser.git
   ```

5. **Fetch & merge the existing `main`** (to bring in the default README/license):

   ```powershell
   git fetch origin main
   git merge origin/main --allow-unrelated-histories
   ```

6. **Resolve any merge conflicts** (if prompted), then:

7. **Stage all your files**:

   ```powershell
   git add .
   ```

8. **Commit**:

   ```powershell
   git commit -m "Initial scaffold: Telegram bot + parser + storage modules"
   ```

9. **Push to GitHub**:

   ```powershell
   git push -u origin main
   ```

---

Once that’s done, your local `JobSynth` folder (with all the modules you created) will be on GitHub alongside the default README and LICENSE.

---

**Grammar & phrasing suggestion**

> **Original:** prefably via cli (powershell).
> **Revised:** Preferably via the command line (PowerShell).
