#!/usr/bin/env python3
"""
Script to automatically fix Jaspr 0.18.x component build signatures.
Changes:
1. Component build(BuildContext context) => Iterable<Component> build(BuildContext context) sync*
2. return ... => yield ...
3. .text(...) => text(...)
"""

import re
import os
import sys

def fix_build_signature(content):
    """Fix the build method signature and return statements."""
    # Fix build signature
    content = re.sub(
        r'(\s+)@override\s+Component build\(BuildContext context\)\s*{',
        r'\1@override\n\1Iterable<Component> build(BuildContext context) sync* {',
        content
    )

    # Fix simple return statements (return X; => yield X;)
    # This is a simplified regex - handle with care
    content = re.sub(
        r'(\s+)return ([^;]+);',
        r'\1yield \2;',
        content
    )

    # Fix .text() calls
    content = re.sub(r'\.text\(', r'text(', content)

    return content

def process_file(filepath):
    """Process a single Dart file."""
    print(f"Processing: {filepath}")

    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content
        content = fix_build_signature(content)

        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  ✓ Updated: {filepath}")
            return True
        else:
            print(f"  - No changes: {filepath}")
            return False
    except Exception as e:
        print(f"  ✗ Error processing {filepath}: {e}")
        return False

def main():
    # Define directories to process
    base_dir = "/Users/brianfopiano/Developer/RemoteGit/ArcaneArts/arcane/arcane_jaspr/lib/component"

    subdirs = [
        "view",
        "navigation",
        "screen",
        "support"
    ]

    files_processed = 0
    files_updated = 0

    for subdir in subdirs:
        dir_path = os.path.join(base_dir, subdir)
        if not os.path.exists(dir_path):
            print(f"Directory not found: {dir_path}")
            continue

        for root, dirs, files in os.walk(dir_path):
            for file in files:
                if file.endswith('.dart'):
                    filepath = os.path.join(root, file)
                    files_processed += 1
                    if process_file(filepath):
                        files_updated += 1

    print(f"\n{'='*60}")
    print(f"Summary:")
    print(f"  Files processed: {files_processed}")
    print(f"  Files updated: {files_updated}")
    print(f"{'='*60}")

if __name__ == "__main__":
    main()
