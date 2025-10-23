# OpenCog AtomSpace Integration Example

This example demonstrates how to use the OpenCog AtomSpace integration in cortex.llamacpp for knowledge representation and cognitive reasoning.

## Prerequisites

1. Build the cortex.llamacpp library with OpenCog support
2. Build the example server
3. Deploy the library to the server's engines directory

## Starting the Server

```bash
cd examples/server/build
mkdir -p engines/cortex.llamacpp
cp ../../../build/libengine.so engines/cortex.llamacpp/
./server
```

The server will start on `http://localhost:3928`

## Using the OpenCog APIs

### 1. Adding Knowledge Triples

Store semantic knowledge as subject-predicate-object triples:

```bash
curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Einstein",
    "predicate": "developed",
    "object": "Theory of Relativity"
  }'
```

**Response:**
```json
{
    "message": "Knowledge added successfully",
    "object": "Theory of Relativity",
    "predicate": "developed",
    "subject": "Einstein"
}
```

### 2. Building a Knowledge Graph

Add multiple related facts:

```bash
# Add more facts about Einstein
curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Einstein",
    "predicate": "born_in",
    "object": "Germany"
  }'

curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Einstein",
    "predicate": "received",
    "object": "Nobel Prize"
  }'

# Add related concepts
curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Theory of Relativity",
    "predicate": "type",
    "object": "Physics"
  }'
```

### 3. Querying Knowledge

Query the knowledge graph using pattern matching:

```bash
curl http://localhost:3928/queryknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "pattern": "Einstein"
  }'
```

**Response:**
```json
{
    "matches": [
        {
            "predicates": [
                {
                    "objects": ["Germany"],
                    "predicate": "born_in"
                },
                {
                    "objects": ["Theory of Relativity"],
                    "predicate": "developed"
                },
                {
                    "objects": ["Nobel Prize"],
                    "predicate": "received"
                }
            ],
            "subject": "Einstein"
        }
    ]
}
```

### 4. Getting AtomSpace Statistics

Monitor the knowledge graph size and usage:

```bash
curl http://localhost:3928/atomspace/stats \
  -H 'Content-Type: application/json' \
  -d '{}'
```

**Response:**
```json
{
    "total_atoms": 4,
    "knowledge_triples": 3,
    "concepts": 0,
    "message": "AtomSpace statistics retrieved successfully"
}
```

## Use Cases

### 1. Semantic Memory for LLM Conversations

Store facts extracted from conversations:

```bash
# After an LLM conversation about science
curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Marie Curie",
    "predicate": "discovered",
    "object": "Radium"
  }'
```

Later, query this knowledge to provide context for future conversations.

### 2. Knowledge Graph Construction

Build domain-specific knowledge graphs:

```bash
# Medical knowledge
curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Aspirin",
    "predicate": "treats",
    "object": "Pain"
  }'

curl http://localhost:3928/addknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "subject": "Aspirin",
    "predicate": "class",
    "object": "NSAID"
  }'
```

### 3. Relationship Discovery

Find related concepts through graph traversal:

```bash
# Query for all facts about a subject
curl http://localhost:3928/queryknowledge \
  -H 'Content-Type: application/json' \
  -d '{
    "pattern": "Theory of Relativity"
  }'
```

## Integration with LLM Inference

The AtomSpace can be used alongside LLM inference:

1. **Context Enhancement**: Query relevant knowledge before generating responses
2. **Fact Checking**: Verify LLM outputs against stored knowledge
3. **Learning**: Store new facts learned during conversations
4. **Reasoning**: Use stored relationships to improve inference quality

## Architecture

The OpenCog integration consists of:

- **AtomSpaceWrapper**: Lightweight hypergraph implementation
- **Knowledge Storage**: In-memory triple store (subject-predicate-object)
- **Pattern Matching**: Query capabilities for semantic search
- **Persistence**: JSON-based export/import (future enhancement)

## Performance

- Optimized for edge computing
- In-memory storage for fast access
- Suitable for knowledge graphs up to millions of atoms
- Minimal overhead on LLM inference

## Future Enhancements

- Advanced reasoning algorithms
- Distributed AtomSpace support
- Graph algorithms (PageRank, shortest path)
- Integration with vector embeddings
- Automatic knowledge extraction from LLM outputs
