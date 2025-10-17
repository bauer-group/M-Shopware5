# {{TITLE}}

> {{DESCRIPTION}}

---

## 📋 Overview

This meta repository automatically synchronizes and organizes projects from the **{{ORGANIZATION}}** organization based on GitHub topics.

**Last synchronized:** {{DATE}}

## 🎯 Purpose

This repository serves as a central hub for:
- 📦 **Submodule Management** - All projects are included as Git submodules
- 📊 **Documentation** - Automatically generated lists of all projects
- 🔍 **Discovery** - Easy browsing of project portfolio by category
- 🔄 **Synchronization** - Automatic updates when projects change

## 📦 Project Collections

{{GROUPS}}

## 🔄 Automatic Synchronization

This repository is automatically maintained by GitHub Actions:

- **Schedule**: Weekly updates every Saturday at 23:45 UTC
- **Triggers**:
  - Scheduled runs (cron)
  - Manual workflow dispatch
  - Repository dispatch events from individual projects
- **Updates**:
  - Submodules are updated to latest commits
  - README.md is regenerated with current project lists
  - JSON/TXT files are updated with repository metadata

## 📁 Repository Structure

```
.
├── Plugins/              # Submodules organized by topic
│   ├── Plugin1/
│   ├── Plugin2/
│   └── ...
├── Themes/               # Another topic group
├── shopware5-plugins.json  # Machine-readable project list
├── shopware5-plugins.txt   # Simple text list
└── README.md             # This file (auto-generated)
```

## 🚀 Usage

### Clone with Submodules

```bash
# Clone the meta repository with all submodules
git clone --recursive https://github.com/{{ORGANIZATION}}/meta-repository-name.git

# Or initialize submodules after cloning
git clone https://github.com/{{ORGANIZATION}}/meta-repository-name.git
cd meta-repository-name
git submodule update --init --recursive
```

### Update All Submodules

```bash
# Update all submodules to their latest commits
git submodule update --remote --recursive
```

### Work with Individual Projects

```bash
# Navigate to a specific project
cd Plugins/ProjectName

# Make changes
git checkout -b feature/my-feature
# ... make changes ...
git commit -am "feat: add new feature"
git push origin feature/my-feature

# Return to meta repository
cd ../..
```

## 📊 Data Formats

### JSON Format
Each topic group has a corresponding `.json` file containing:
- Repository name
- Description
- Default branch
- HTML and Git URLs
- Topics
- Last update timestamp

### TXT Format
Simple newline-separated list of repository names for easy scripting.

## 🤝 Contributing

This is an automated repository. To contribute:

1. **Make changes in individual projects** - Commit to the actual project repositories
2. **Trigger sync** - The meta repository will update automatically, or trigger manually via workflow dispatch
3. **Update configuration** - Modify `.github/config/meta-repository/topics.json` to change grouping

## 📞 Support

For issues with individual projects, please use their respective issue trackers.
For meta repository configuration or synchronization issues, open an issue in this repository.

---

*This README is automatically generated. Do not edit manually - changes will be overwritten.*
*Generated on {{DATE}}*
## 📦 📦 Enthaltene Plugins

Die gesamte Sammlung von Plugins für Shopware 5

| Repository | Description | Link |
|------------|-------------|------|
| **AmazonToolkit** | Das Plugin passt im Rahmen optimalen Verarbeitung von Amazon Marktplatzaufträgen bestimmte Abläufe im Shop entsprechend an. | [View](https://github.com/bauer-group/SWP-AmazonToolkit) |
| **AppleIOS933Hotfix** | Das Plugin wendet die von Shopware empfohlene Problemlsung zum Problem mit dem Warenkorb fr das Apple iOS 9.3.3 an. Mit der aktuellen iOS-Version 9.3.3 gibt es Probleme einen Artikel in den Warenkorb zu legen. Ursache dafr ist, dass der User-Agent des Apple-Gertes von Shopware als Bot erkannt wird. Durch diesen Umstand funktionieren einige Funkt... | [View](https://github.com/bauer-group/SWP-AppleIOS933Hotfix) |
| **ArticleWeight** | Das Plugin zeigt im Storefront das Artikelgewicht, auf der Detailseite, an. | [View](https://github.com/bauer-group/SWP-ArticleWeight) |
| **AutomaticDocuments** | Das Plugin erstellt und versendet die Rechnung und den Lieferschein zu einer Bestellung automatisch nach Bestellabschluss.Vorteile:&nbsp;- Konfigurierbar, nach individuellen Vorgaben.&nbsp;- Belegerstellung erfolgt leistungsoptimiert durch einen eigenen Hintergrundprozess, unabhängig vom Checkout.&nbsp;- getested für den Einsatz in hochfrequenti... | [View](https://github.com/bauer-group/SWP-AutomaticDocuments) |
| **BauergroupSlowArticleExport** | Das Plugin exportiert Lagerhüter, wenn diese in einem bestimmtem Zeitraum nicht gekauft wurden. | [View](https://github.com/bauer-group/SWP-BauergroupSlowArticleExport) |
| **BootstrapIntegration** | Das Plugin ermöglich die einfache Einbindung von Bootstrap in ihrem Shoptemplate. Alle Bootstrap Gestaltungselemente sind im Namensraum 'bootstrap-styles' untergebracht. | [View](https://github.com/bauer-group/SWP-BootstrapIntegration) |
| **CheckoutCostCenter** | Das Plugin fügt im Checkout ein Eingabefeld zur Erfassung einer Kostenstelle hinzu. Die erfasste Kostenstelle wird im Freitextfeld 6 der Bestellung abgelegt. Es handelt sich dabei um ein Pflichtfeld. | [View](https://github.com/bauer-group/SWP-CheckoutCostCenter) |
| **CheckoutPromotion** | Das Plugin erweitert den seitlichen Warenkorb (Ajax Warenkorb) um einen Werbebanner mit Artikelverknüpfung. Der Artikel kann direkt innerhalb des Warenkorbs hinzugefügt werden. Die Bestellbestätigungsseite wird um einen Aktionsbanner erweitert, der ebenfalls verlinkt wird mit einer frei definierbaren Aktionsseite. | [View](https://github.com/bauer-group/SWP-CheckoutPromotion) |
| **CookieConsent** | Integration des Consent Managers von Cookie First (cookiefirst.com). Mit diesem Plugin können sie die Lösung von cookiefirst.com schnell und Einfach in ihren Shopware Shop integrieren. Bitte beachten sie das individuelle Anpassungen je Shop erforderlich sind, um die Funktion entsprechend den gesetzlichen Anforderungen, sicherzustellen. Prüfen si | [View](https://github.com/bauer-group/SWP-CookieConsent) |
| **CovidTickets** | Das Plugin setzt die Anpassungen für den COVID 19 Ticketverkauf um. | [View](https://github.com/bauer-group/SWP-CovidTickets) |
| **CreateDocuments** | Das Plugin erzeugt nach dem Bestellabschluss die PDF Dokumente zur Bestellung automatisch. | [View](https://github.com/bauer-group/SWP-CreateDocuments) |
| **CustomPriceFluctuation** | Das Plugin lässt die Artikelpreise Preis wie konfiguriert schwanken. Die Preisanpassungen erfolgen abhängig von der Steuereinstellung. Die Preisanpassung gilt also immer auf den Verkauspreis (brutto/netto). | [View](https://github.com/bauer-group/SWP-CustomPriceFluctuation) |
| **CustomPriceManager** | Das Plugin ändert einen Artikelpreis, wenn dieser in einem bestimmtem Zeitraum nicht gekauft wurde. Dabei werden verschiedene Regeln angewendet, die entsprechend konfiguriert werden können. Die Preisanpassungen erfolgen abhängig von der Steuereinstellung. Die Preisanpassung gilt also immer auf den Verkauspreis (brutto/netto). | [View](https://github.com/bauer-group/SWP-CustomPriceManager) |
| **CustomerDataInTemplate** | Das Plugin fügt im Template Variablen zur Benutzeridentifizierung hinzu. Diese können im Template zur inhaltlichen Anpassung verwendet werden. | [View](https://github.com/bauer-group/SWP-CustomerDataInTemplate) |
| **CustomerDiscount** | Das Plugin ermöglich pro Kunde einen individuelle Rabatt im Warenkorb. Der individuelle Rabatt wird in einem Attributsfeld beim Kunden hinterlegt. | [View](https://github.com/bauer-group/SWP-CustomerDiscount) |
| **DocumentAPI** | Das Plugin erweitert die API um die Möichkeit PDF Dokumente zur Bestellung abzurufen. | [View](https://github.com/bauer-group/SWP-DocumentAPI) |
| **DocumentAppend** | Das Plugin fügt ein definierbares PDF Dokument automatisch im Rahmen der Dokumentenerstellung an das erstellte Dokument an. Im Ergebnis wird ein PDF Dokument erzeugt das aus dem Shopware Dokument und in den Folgeseiten aus dem bereitgestellten Dokument besteht. Unterstüzt werden Rechnung und Lieferschein. | [View](https://github.com/bauer-group/SWP-DocumentAppend) |
| **DocumentSender** | Das Plugin sendet bereit erstellte PDF Dokumente zur Bestellung automatisch bei einem Statuswechsel in den konfigurierten Status. Das verwendete Mailtemplate entspricht dem bereits vorhandenen Mailtemplate von Shopware für die Statusbenachrichtigung. | [View](https://github.com/bauer-group/SWP-DocumentSender) |
| **DocumentsSafety** | Das Plugin stellt sicher das alle erstellten Bestellungen die konfigurierten PDF Dokumente automatisch erstellt bekommen. Auch bei manuell in der Datenbank eingetragenen Bestellungen oder Bestellungen die im Backend erstellt wurden. | [View](https://github.com/bauer-group/SWP-DocumentsSafety) |
| **FullIPAddress** | Das Plugin zeigt die vollständige IP-Adresse zur Bestellung an. | [View](https://github.com/bauer-group/SWP-FullIPAddress) |
| **GermanVATChanger** | Das Plugin passt im Rahmen der Senkung der MwSt. / USt. automatisch am Stichtag '01.07.2020 00:00' gesenkt (von 19% auf 16% und von 7% auf 5%). Ebenso wird der Steuersatz wieder am Stichtag '01.01.2021 00:00' automatisch erhöht. Das Plugin benötigt zwingend aktivierte und funktionierende Cronjobs im Shop für die ordnungsgemäße Funktion. Das Plug | [View](https://github.com/bauer-group/SWP-GermanVATChanger) |
| **IndependentShippingNotification** | Das Plugin versendet zeitgesteuert (CronJob) E-Mails, nachdem die Trackingnummer hinterlegt wurde und zusätzlich der Bestellstatus auf 'komplett ausgeliefert' gesetzt wurde. | [View](https://github.com/bauer-group/SWP-IndependentShippingNotification) |
| **ListingPromotions** | Es werden Promotionen im Artikellisting erstellt. Diese können in der Kategoriekonfiguration für jede Produktkategorie definiert werden. | [View](https://github.com/bauer-group/SWP-ListingPromotions) |
| **MailMessageBlocker** | Das Plugin leitet Emailnachrichten die durch den Shop versendet werden um, auf eine andere Adresse. Sofern in der Nachricht das Schlüsselwort '[BGMAILBLOCKER]' gefunden wird. Das kann über die Mailtemplates und deren Regelwerke nach Bedarf eingefügt werden. Das Schlüsselwort darf dabei unsichtbar einbeunden werden (z. B. als HTML Kommentar). | [View](https://github.com/bauer-group/SWP-MailMessageBlocker) |
| **OrderStatusAutomation** | Das Plugin erweitert Shopware für zwei definierbare Zahlungsmöglichkeiten ein automatisches setzen des Bestellstatus und Zahlungsstatus zu realisieren. Das Plugin ist bereits für Nachname und Rechnung vorkonfiguriert. Der Status zur Bestellung wird damit auch wie bei anderen Zahlungsmöglichkeiten automatisch gesetzt. Damit kann der Auftrag ohne ... | [View](https://github.com/bauer-group/SWP-OrderStatusAutomation) |
| **OrderTimestampCorrection** | Das Plugin korrigiert den Bestellzeitpunkt, für Umgebungen bei denen der MySQL Server als Zeitzone UTC verwendet. Als Zeitzone für den Bestellzeitpunkt wird die PHP Einstellung verwendet. Ohne die Korrektur wird der Bestellzeitpunkt falsch angezeigt. Im Backend steht die UTC Zeitangabe, die aber falsch als lokale Zeitangabe ausgewiesen wird. Das... | [View](https://github.com/bauer-group/SWP-OrderTimestampCorrection) |
| **RemoveBackground** | Das Plugin stellt die hochgeladenen Bilder automatisch frei. Dazu wird der Dienst https://www.remove.bg/ verwendet. Sie benötigen hierfür einen entsprechenden Account. | [View](https://github.com/bauer-group/SWP-RemoveBackground) |
| **SMSNotifier** | Das Plugin schickt eine Bewertungsaufforderung per SMS an die Kunden. | [View](https://github.com/bauer-group/SWP-SMSNotifier) |
| **SalesVolumeLimiter** | Das Plugin schafft die Möglichkeit pro Artikel eine Reservierte Menge zu bestimmen, die von der definierten Kundengruppe nicht erworben werden kann. | [View](https://github.com/bauer-group/SWP-SalesVolumeLimiter) |
| **ShoppingWorldVimeo** | Das Plugin fügt in der Einkaufswelt die Möglichkeit der Einbettung von vimeo.com Videos hinzu. | [View](https://github.com/bauer-group/SWP-ShoppingWorldVimeo) |
| **SocialRecommend** | Das Plugin fügt in der Artikeldetailansicht einen Tweet Button für Twitter und einen Google +1 Button ein. Die Buttons werden mit einer horizontale Zählung dargestellt. | [View](https://github.com/bauer-group/SWP-SocialRecommend) |
| **SpecialSaleExtension** | Special Sale AddOn's | [View](https://github.com/bauer-group/SWP-SpecialSaleExtension) |
| **StockBalanceByPackaging** | Das Plugin rechnet die übertragenenen Mengen über die REST API in VE, anhand der Angaben in der Grundpreisberechnung um. | [View](https://github.com/bauer-group/SWP-StockBalanceByPackaging) |
| **TaxIdentification** | Das Plugin zeigt den Steuerausweis für jeden Steuersatz getrennt mit den zugehörigen Nettobeträgen an. Damit Entspricht die Rechnung dem § 14 Abs. 4 Nr. 7 UStG in Verbindung mit § 33 UStDV (es ist das nach Steuersätzen und einzelnen Steuerbefreiungen aufgeschlüsselte Netto-Entgelt anzugeben). | [View](https://github.com/bauer-group/SWP-TaxIdentification) |
| **TwitterTweet** | Das Plugin fügt in der Artikeldetailansicht einen Tweet Button für Twitter ein. Der Button wird mit einer horizontale Zählung dargestellt. | [View](https://github.com/bauer-group/SWP-TwitterTweet) |
| **WarrantyReminder** | Die Kunden werden nach Ablauf von einer definierten Zahl an Tagen, nach der Bestellung über die Option einer Garantieerweiterung informiert. | [View](https://github.com/bauer-group/SWP-WarrantyReminder) |
| **ZammadIntegration** | Das Plugin ermöglich die einfache Einbindung des Zammad Chatwidgets in ihrem Shop. | [View](https://github.com/bauer-group/SWP-ZammadIntegration) |


