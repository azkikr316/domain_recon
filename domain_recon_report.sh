#!/bin/bash

# Usage: ./domain_recon_report.sh example.com

DOMAIN=$1
OUTPUT="recon_report.html"
IP=$(dig +short $DOMAIN A | head -n1)
DATE=$(date)

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 domain.com"
  exit 1
fi

# Start HTML
cat <<EOF > $OUTPUT
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Recon Report for $DOMAIN</title>
<style>
body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 20px; padding: 20px; }
h1 { background: #222; color: white; padding: 10px; }
h2 { color: #333; border-bottom: 1px solid #ccc; }
pre { background: #fff; border: 1px solid #ccc; padding: 10px; overflow-x: auto; }
</style>
</head>
<body>
<h1>Recon Report for $DOMAIN</h1>
<p><strong>Date:</strong> $DATE</p>
EOF

# Section Function
add_section() {
  echo "<h2>$1</h2><pre>" >> $OUTPUT
  echo "$2" >> $OUTPUT
  echo "</pre>" >> $OUTPUT
}

add_section "A Records (IPv4)" "$(dig +short $DOMAIN A)"
add_section "AAAA Records (IPv6)" "$(dig +short $DOMAIN AAAA)"
add_section "CNAME Record" "$(dig +short $DOMAIN CNAME)"
add_section "MX Records" "$(dig +short $DOMAIN MX)"
add_section "NS Records" "$(dig +short $DOMAIN NS)"
add_section "SOA Record" "$(dig +noall +answer $DOMAIN SOA)"
add_section "PTR Record (Reverse DNS)" "$(dig -x $IP +short 2>/dev/null)"
add_section "WHOIS Info" "$(whois $DOMAIN | grep -E "Domain Name|Registrar|Registrant|Creation Date|Expiry Date|Name Server")"
add_section "Host Info" "$(host $DOMAIN)"
add_section "nslookup Info" "$(nslookup $DOMAIN)"
add_section "HTTP Headers (curl -I)" "$(curl -sI https://$DOMAIN | grep -E 'HTTP/|server:|content-type:|cache-control:|x-vercel|x-nextjs|strict-transport-security|access-control-allow-origin')"
add_section "IPInfo (Geolocation, ASN)" "$(curl -s ipinfo.io/$IP)"
add_section "Nmap Quick Scan" "$(nmap -F $IP)"

# Finish HTML
cat <<EOF >> $OUTPUT
</body>
</html>
EOF

echo "✅ Report generated: $OUTPUT"
