
import os
from pathlib import Path

base_dir = Path(__file__).resolve().parent / "scripts"
html_path = Path(__file__).resolve().parent / "docs" / "index.html"

html = [
    "<!DOCTYPE html>",
    "<html lang='en'><head><meta charset='UTF-8'>",
    "<title>House of Kube – Script Index</title>",
    "<style>body{font-family:sans-serif;padding:2rem;max-width:1000px;margin:auto;}",
    "h1{color:#222;}code{background:#eee;padding:2px 4px;border-radius:4px;}",
    "ul{padding-left:1rem;}li{margin-bottom:0.75rem;}.level{font-size:0.85em;color:#666;}",
    "</style></head><body><h1>🏯 House of Kube — Script Index</h1><p>Below is the list of kubectl creation scripts grouped by category:</p>"
]

for cat in sorted(p.name for p in base_dir.iterdir() if p.is_dir()):
    html.append(f"<section><h2>📂 {cat}/</h2><ul>")
    for f in sorted((base_dir / cat).glob("*.sh")):
        lines = f.read_text().splitlines()
        usage = next((l.strip('# ').strip() for l in lines if 'Usage:' in l), '')
        level = next((l.strip('# ').strip() for l in lines if 'Level:' in l), 'Level: unknown')
        html.append(f"<li><strong>{f.name}</strong> <span class='level'>({level})</span><br><code>{usage}</code></li>")
    html.append("</ul></section>")

html.append("</body></html>")
html_path.write_text("\n".join(html))
