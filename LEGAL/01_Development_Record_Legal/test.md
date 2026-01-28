"""

    session_slug = safe_slug(args.session)

    chat_log_md.py
    Append AI chat logs to Markdown with an integrity ledger (hash chaining).

    Usage (examples):
      python chat_log_md.py --session "HUD_Dev" --infile chat.txt
      python chat_log_md.py --session "CPAS_Legal" --text "Paste text here..."
      python chat_log_md.py --session "CPAS_Legal" --clipboard
    
    Notes:
    - Produces:
      logs/<session>/YYYY-MM-DD_HHMMSS_<session>.md
      logs/<session>/ledger.jsonl   (append-only hash chain)
    """
    
    from __future__ import annotations

    import argparse
    import datetime as dt
    import hashlib
    import json
    import os
    import re
    import sys
    
    try:
        import pyperclip  # optional: pip install pyperclip
    except Exception:
        pyperclip = None
    
    
    def now_local_iso() -> str:
        # local time with seconds
        return dt.datetime.now().astimezone().isoformat(timespec="seconds")
    
    
    def safe_slug(s: str) -> str:
        s = s.strip()
        s = re.sub(r"[^\w\- ]+", "", s)
        s = re.sub(r"\s+", "_", s)
        return s[:60] or "SESSION"
    
    
    def sha256_hex(data: bytes) -> str:
        return hashlib.sha256(data).hexdigest()
    
    
    def ensure_dir(path: str) -> None:
        os.makedirs(path, exist_ok=True)
    
    
    def read_text_file(path: str) -> str:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    
    
    def write_text_file(path: str, text: str) -> None:
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(text)
    
    
    def append_jsonl(path: str, obj: dict) -> None:
        with open(path, "a", encoding="utf-8", newline="\n") as f:
            f.write(json.dumps(obj, ensure_ascii=False) + "\n")
    
    
    def get_last_ledger_hash(ledger_path: str) -> str:
        if not os.path.exists(ledger_path):
            return "0" * 64
        last = None
        with open(ledger_path, "r", encoding="utf-8", errors="replace") as f:
            for line in f:
                line = line.strip()
                if line:
                    last = line
        if not last:
            return "0" * 64
        try:
            obj = json.loads(last)
            return str(obj.get("entry_hash", "0" * 64))
        except Exception:
            return "0" * 64
    
    
    def md_wrap_raw_block(text: str) -> str:
        """
        Wrap raw chat text so Markdown won't reinterpret bullets, etc.
        Triple-backtick fences are safest for 'proof of work' logs.
        """
        # If the text contains ``` we can fence with ~~~ instead.
        fence = "```"
        if "```" in text:
            fence = "~~~"
        return f"{fence}text\n{text.rstrip()}\n{fence}\n"
    
    
    def build_md(session: str, captured_at: str, source: str, raw_text: str, entry_hash: str, prev_hash: str) -> str:
        return (
            f"# Chat Log — {session}\n"
            f"- Captured: {captured_at}\n"
            f"- Source: {source}\n"
            f"- Prev Ledger Hash: `{prev_hash}`\n"
            f"- Entry Hash: `{entry_hash}`\n"
            f"\n"
            f"## Raw Transcript\n\n"
            f"{md_wrap_raw_block(raw_text)}\n"
        )
    
    
    def main() -> int:
        ap = argparse.ArgumentParser()
        ap.add_argument("--session", required=True, help="Session name, e.g. HUD_Dev or CPAS_Legal")
        ap.add_argument("--infile", help="Path to a text file containing chat transcript")
        ap.add_argument("--text", help="Direct text to log (use quotes)")
        ap.add_argument("--clipboard", action="store_true", help="Read transcript from clipboard (requires pyperclip)")
        ap.add_argument("--outdir", default="logs", help="Base output folder (default: logs)")
        args = ap.parse_args()
    
        session_slug = safe_slug(args.session)
        session_dir = os.path.join(args.outdir, session_slug)
        ensure_dir(session_dir)
    
        ledger_path = os.path.join(session_dir, "ledger.jsonl")
        prev_hash = get_last_ledger_hash(ledger_path)
    
        captured_at = now_local_iso()
    
        # Choose input source
        if args.infile:
            raw_text = read_text_file(args.infile)
            source = f"infile:{os.path.basename(args.infile)}"
        elif args.text is not None:
            raw_text = args.text
            source = "inline_text"
        elif args.clipboard:
            if pyperclip is None:
                print("ERROR: pyperclip not available. Run: pip install pyperclip", file=sys.stderr)
                return 2
            raw_text = pyperclip.paste()
            source = "clipboard"
        else:
            print("ERROR: Provide --infile, --text, or --clipboard", file=sys.stderr)
            return 2
    
        raw_bytes = raw_text.encode("utf-8", errors="replace")
    
        # Hash chain: entry_hash = sha256(prev_hash + timestamp + raw_text)
        chain_material = (prev_hash + "\n" + captured_at + "\n").encode("utf-8") + raw_bytes
        entry_hash = sha256_hex(chain_material)
    
        # Write markdown file
        ts = dt.datetime.now().strftime("%Y-%m-%d_%H%M%S")
        md_name = f"{ts}_{session_slug}.md"
        md_path = os.path.join(session_dir, md_name)
        md_text = build_md(session_slug, captured_at, source, raw_text, entry_hash, prev_hash)
        write_text_file(md_path, md_text)
    
        # Append ledger entry
        ledger_entry = {
            "captured_at": captured_at,
            "session": session_slug,
            "source": source,
            "md_file": md_name,
            "prev_hash": prev_hash,
            "entry_hash": entry_hash,
            "raw_sha256": sha256_hex(raw_bytes),
            "byte_len": len(raw_bytes),
        }
        append_jsonl(ledger_path, ledger_entry)
    
        print(f"OK: wrote {md_path}")
        print(f"OK: appended {ledger_path}")
        return 0
    
    
    if __name__ == "__main__":
        raise SystemExit(main())
