# Git Repository Management Scripts

Diese Sammlung von Skripten erleichtert die Verwaltung von Git-Repositories mit Submodulen. Die Skripte sind generisch und können in jedem Repository mit Submodulen verwendet werden.

## Verfügbare Skripte

### 1. Update (Pull)
Aktualisiert das Repository und alle Submodule mit Git LFS Support.

**Linux/Mac:**
```bash
./scripts/update.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\update.ps1
```

**Was macht es:**
- Pulled das Hauptrepository vom aktuellen Branch
- Aktualisiert alle Submodule auf den neuesten Stand
- Lädt alle Git LFS Dateien herunter

---

### 2. Push (Commit & Push)
Schreibt Änderungen zurück ins Repository und alle modifizierten Submodule.

**Linux/Mac:**
```bash
./scripts/push.sh "Commit-Nachricht"
# oder ohne Argument für interaktive Eingabe
./scripts/push.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\push.ps1 "Commit-Nachricht"
# oder ohne Argument für interaktive Eingabe
.\scripts\push.ps1
```

**Was macht es:**
- Prüft auf Änderungen in allen Submodulen
- Committed und pushed Änderungen in den Submodulen zuerst
- Aktualisiert die Submodul-Referenzen im Hauptrepository
- Committed und pushed das Hauptrepository

---

### 3. Status
Zeigt den Status des Repositories und aller Submodule an.

**Linux/Mac:**
```bash
./scripts/status.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\status.ps1
```

**Was macht es:**
- Zeigt den aktuellen Branch und Status des Hauptrepos
- Warnt, wenn das Repository hinter dem Remote ist
- Listet alle Submodule mit ihrem Status auf
- Zeigt uncommitted Änderungen in Submodulen an

---

### 4. Clone
Klont das komplette Repository mit allen Submodulen (für neue Setups).

**Linux/Mac:**
```bash
./scripts/clone.sh <repository-url> [Zielverzeichnis]
# Beispiel:
./scripts/clone.sh https://github.com/bauer-group/X-Shopware5.git
./scripts/clone.sh https://github.com/bauer-group/X-Shopware5.git mein-ordner
```

**Windows (PowerShell):**
```powershell
.\scripts\clone.ps1 <repository-url> [Zielverzeichnis]
# Beispiel:
.\scripts\clone.ps1 https://github.com/bauer-group/X-Shopware5.git
.\scripts\clone.ps1 https://github.com/bauer-group/X-Shopware5.git mein-ordner
```

**Was macht es:**
- Klont das Hauptrepository
- Initialisiert und updated alle Submodule parallel
- Lädt alle Git LFS Dateien herunter

---

## Voraussetzungen

### Git
Alle Skripte benötigen Git. Installation:
- **Windows:** https://git-scm.com/download/win
- **Linux:** `sudo apt-get install git` (Debian/Ubuntu) oder `sudo yum install git` (RHEL/CentOS)
- **Mac:** `brew install git`

### Git LFS (Optional aber empfohlen)
Für große Dateien wird Git LFS verwendet. Installation:
- **Windows/Mac/Linux:** https://git-lfs.github.com/

Nach der Installation:
```bash
git lfs install
```

### Berechtigungen (Linux/Mac)
Bash-Skripte müssen ausführbar gemacht werden:
```bash
chmod +x scripts/*.sh
```

## Workflow-Beispiele

### Tägliche Arbeit starten
```bash
# Aktuelles Repository auf den neuesten Stand bringen
./scripts/update.sh

# Status prüfen
./scripts/status.sh
```

### Änderungen zurückschreiben
```bash
# Erst Status prüfen
./scripts/status.sh

# Änderungen pushen
./scripts/push.sh "Beschreibung der Änderungen"
```

### Neues Repository Setup
```bash
# Komplettes Repo mit allen Submodulen klonen
./scripts/clone.sh https://github.com/user/repo.git mein-verzeichnis
cd mein-verzeichnis

# Status prüfen
./scripts/status.sh
```

## Troubleshooting

### Submodule werden nicht aktualisiert
```bash
# Submodule manuell neu initialisieren
git submodule deinit --all -f
git submodule update --init --recursive
```

### LFS Dateien fehlen
```bash
# LFS neu installieren und Dateien pullen
git lfs install
git lfs pull
git submodule foreach --recursive 'git lfs pull'
```

### Merge-Konflikte in Submodulen
```bash
# In das betroffene Submodul wechseln
cd Plugins/PluginName

# Konflikt lösen
git status
# ... Konflikt manuell lösen ...
git add .
git commit

# Zurück zum Hauptrepository
cd ../..
git add Plugins/PluginName
git commit -m "Resolve submodule conflict"
```

## Hinweise

- Alle Skripte unterstützen **Git LFS** automatisch
- Die Skripte arbeiten mit dem **aktuellen Branch**
- Bei Fehlern werden die Skripte mit einer Fehlermeldung abgebrochen
- Farbige Ausgaben helfen bei der Übersicht (Grün = Erfolg, Gelb = Warnung, Rot = Fehler)
- **Die Skripte sind generisch** und ermitteln den Repository-Namen automatisch aus der Git-Remote-URL
- Skripte können in beliebige Repositories kopiert und dort verwendet werden
