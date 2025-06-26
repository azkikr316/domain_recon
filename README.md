# 🔍 Domain Recon Toolkit

This repository provides two Bash scripts for performing reconnaissance on websites and domains. They are ideal for security researchers, penetration testers, and DevSecOps professionals conducting footprinting or passive information gathering.

---

## 📁 Scripts

### 1. `domain_recon.sh`

A **simple and fast CLI tool** that gathers basic domain and server information using native Linux tools.

#### 🔧 Features

- DNS lookups (A, AAAA, MX, CNAME, NS, SOA)
- Reverse DNS (PTR)
- WHOIS query
- HTTP header inspection
- IP geolocation via [ipinfo.io](https://ipinfo.io)
- Quick Nmap scan (common ports)

#### ▶️ Usage

```bash
chmod +x domain_recon.sh
./domain_recon.sh example.com
```

---

### 2. `domain_recon_report.sh`

A **comprehensive HTML report generator** that automates the same recon tasks and formats them into a readable report (`recon_report.html`).

#### 📦 Output

- All the same data as above
- Nicely styled HTML file
- Suitable for reporting and documentation

#### ▶️ Usage

```bash
chmod +x domain_recon_report.sh
./domain_recon_report.sh example.com
xdg-open recon_report.html  # or open manually
```

---

## ✅ Requirements

Install the following dependencies:

```bash
sudo apt install whois dnsutils curl nmap
```

Optional (for advanced fingerprinting, not used by default):
- `whatweb`
- `subfinder`
- `gowitness`

---

## 📘 Example Use Case

Use this toolkit to:
- Investigate a deployed web app’s configuration
- Conduct footprinting before active scanning
- Validate domain hosting and security header setup
- Document findings in a professional HTML report

---

## 📜 License

MIT License. Feel free to modify and contribute.

---

## 🙌 Contributions

Pull requests and feature suggestions are welcome!
