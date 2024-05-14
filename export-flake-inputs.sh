#!/bin/sh

# Evaluate the inputOutPaths and get the JSON output.
inputOutPaths=$(nix eval .#inputOutPaths --json)

echo "Exporting flake inputs."
echo ""
echo "When attempting to build the flake on the target, run:"
echo ""
echo "  nix build \\"

# Use jq to extract the paths and loop through them.
echo "$inputOutPaths" | jq -r 'to_entries[] | "\(.key) \(.value)"' | while read -r name path; do
  # Create a NAR file for each path.
  echo "    --override-input ${name} ${path} \\"
  nix copy --to file://${PWD}/nix-copy-output ${path}
done

echo "    .#vm"
echo ""
