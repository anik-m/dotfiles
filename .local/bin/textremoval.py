#!/usr/bin/env python3

import subprocess
import sys
import re

def get_foreign_packages():
    """Gets the list of foreign packages using pacman -Qm."""
    try:
        result = subprocess.run(['pacman', '-Qm'], capture_output=True, text=True, check=True)
        return result.stdout.splitlines()
    except subprocess.CalledProcessError:
        print("Error: Could not retrieve foreign packages from pacman.", file=sys.stderr)
        return []

def remove_packages_from_file(filepath, packages_to_remove):
    """Removes lines containing specified packages from a file.

    Args:
        filepath: The path to the file to modify.
        packages_to_remove: A list of package names (strings) to remove.
                             The package names should be exactly as they appear
                             in the output of pacman -Qm (including version).
    """
    try:
        with open(filepath, 'r') as f:
            lines = f.readlines()
    except FileNotFoundError:
        print(f"Error: File not found: {filepath}", file=sys.stderr)
        return

    # Build a regex pattern to match any of the packages
    # We escape any special regex characters in the package names.
    escaped_packages = [re.escape(pkg) for pkg in packages_to_remove]
    # The pattern matches the beginning of the line (^), then any of the
    # escaped package names, followed by a space or the end of the line.  This
    # prevents accidentally removing lines that *contain* a package name as part
    # of a larger string.  The r'' string is a raw string, avoiding issues with
    # backslashes.
    pattern = r"^(?:" + "|".join(escaped_packages) + r")(?:\s|$).*"

    # Filter out lines that match any of the packages to be removed.
    filtered_lines = [line for line in lines if not re.match(pattern, line)]

    # Check if any changes were made before writing to the file.
    if len(filtered_lines) != len(lines):
        try:
            with open(filepath, 'w') as f:
                f.writelines(filtered_lines)
            print(f"Successfully updated {filepath}")
        except IOError as e:
            print(f"Error: Could not write to file: {filepath} ({e})", file=sys.stderr)
    else:
        print(f"No matching packages found in {filepath} to remove.")


def main():
    """Main function to get foreign packages and remove them from a file."""
    if len(sys.argv) != 2:
        print("Usage:  python script.py <filepath>", file=sys.stderr)
        print("  <filepath>: The path to the file to modify.", file=sys.stderr)
        sys.exit(1)

    filepath = sys.argv[1]
    foreign_packages = get_foreign_packages()

    if not foreign_packages:
        sys.exit(1) # Exit if there was an error getting packages.

    # Extract package names, handling versions correctly.
    #  pacman -Qm output is typically "package-name version-info"
    package_names = [pkg.split()[0] for pkg in foreign_packages]


    remove_packages_from_file(filepath, package_names)


if __name__ == "__main__":
    main()
