#!/bin/bash

# Test script for OpenCog AtomSpace integration with cortex.llamacpp
# This script demonstrates the knowledge storage and retrieval capabilities

set -e

BASE_URL="http://localhost:3928"

echo "=========================================="
echo "OpenCog AtomSpace Integration Test"
echo "=========================================="
echo ""

# Test 1: Add Knowledge
echo "Test 1: Adding knowledge triples..."
echo ""

echo "Adding: Einstein -> developed -> Theory of Relativity"
curl -s -X POST "$BASE_URL/addknowledge" \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Einstein",
    "predicate": "developed",
    "object": "Theory of Relativity"
  }' | python3 -m json.tool

echo ""
echo "Adding: Einstein -> born_in -> Germany"
curl -s -X POST "$BASE_URL/addknowledge" \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Einstein",
    "predicate": "born_in",
    "object": "Germany"
  }' | python3 -m json.tool

echo ""
echo "Adding: Theory of Relativity -> type -> Physics"
curl -s -X POST "$BASE_URL/addknowledge" \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Theory of Relativity",
    "predicate": "type",
    "object": "Physics"
  }' | python3 -m json.tool

echo ""
echo "=========================================="

# Test 2: Query Knowledge
echo ""
echo "Test 2: Querying knowledge..."
echo ""

echo "Querying for: Einstein"
curl -s -X POST "$BASE_URL/queryknowledge" \
  -H 'Content-Type: application/json' \
  -d '{
    "pattern": "Einstein"
  }' | python3 -m json.tool

echo ""
echo "=========================================="

# Test 3: Get AtomSpace Statistics
echo ""
echo "Test 3: Getting AtomSpace statistics..."
echo ""

curl -s -X POST "$BASE_URL/atomspace/stats" \
  -H 'Content-Type: application/json' \
  -d '{}' | python3 -m json.tool

echo ""
echo "=========================================="
echo "All tests completed!"
echo "=========================================="
