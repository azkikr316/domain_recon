#!/bin/bash

# Usage: ./domain_recon.sh example.com

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 domain.com"
  exit 1
fi

echo "=== 🧠 DOMAIN RECON FOR: $DOMAIN ==="
echo ""

echo "📌 A Record (IPv4):"
dig +short $DOMAIN A
echo ""

echo "🌐 AAAA Record (IPv6):"
dig +short $DOMAIN AAAA
echo ""

echo "📦 CNAME Record:"
dig +short $DOMAIN CNAME
echo ""

echo "📬 MX Records:"
dig +short $DOMAIN MX
echo ""

echo "🧭 Name Servers:"
dig +short $DOMAIN NS
echo ""

echo "🗺️ SOA Record:"
dig +noall +answer $DOMAIN SOA
echo ""

echo "🔁 Reverse DNS (PTR) for A Record:"
IP=$(dig +short $DOMAIN A | head -n1)
if [ -n "$IP" ]; then
  dig -x $IP +short
else
  echo "No IP found."
fi
echo ""

echo "🔍 WHOIS Info:"
whois $DOMAIN | grep -E "Domain Name|Registrar|Registrant|Creation Date|Expiry Date|Name Server"
echo ""

echo "🧭 Host Info:"
host $DOMAIN
echo ""

echo "📡 nslookup Info:"
nslookup $DOMAIN
echo ""

echo "🌐 HTTP Response Headers:"
curl -sI https://$DOMAIN | grep -E "HTTP/|server:|content-type:|cache-control:|x-vercel|x-nextjs|strict-transport-security|access-control-allow-origin"
echo ""

echo "🌍 IP Geolocation & ASN:"
if [ -n "$IP" ]; then
  curl -s ipinfo.io/$IP
else
  echo "No IP available."
fi
echo ""

echo "⛏️ Nmap Quick Scan (common ports):"
if [ -n "$IP" ]; then
  nmap -F $IP
else
  echo "No IP to scan."
fi
