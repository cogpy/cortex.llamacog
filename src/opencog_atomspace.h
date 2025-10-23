#pragma once

#include <memory>
#include <string>
#include <vector>
#include <unordered_map>
#include "json/value.h"

namespace opencog {

// Forward declarations for AtomSpace types
class Atom;
class AtomSpace;
class Handle;

/**
 * AtomSpaceWrapper - A lightweight wrapper around OpenCog's AtomSpace
 * for knowledge representation and reasoning in the inference engine.
 * 
 * This provides a simplified interface for:
 * - Storing semantic knowledge from LLM interactions
 * - Pattern matching and knowledge retrieval
 * - Hypergraph-based knowledge representation
 */
class AtomSpaceWrapper {
 public:
  AtomSpaceWrapper();
  ~AtomSpaceWrapper();

  // Knowledge storage operations
  bool AddKnowledge(const std::string& subject, const std::string& predicate, 
                   const std::string& object);
  bool AddConcept(const std::string& concept, const Json::Value& properties);
  
  // Query operations
  Json::Value QueryKnowledge(const std::string& pattern);
  std::vector<std::string> GetRelatedConcepts(const std::string& concept);
  
  // Pattern matching
  bool MatchPattern(const std::string& pattern);
  Json::Value ExecuteQuery(const Json::Value& query);
  
  // Memory management
  void Clear();
  size_t GetAtomCount() const;
  
  // Export/Import for persistence
  bool ExportToFile(const std::string& filepath);
  bool ImportFromFile(const std::string& filepath);
  
  // Get statistics
  Json::Value GetStatistics() const;

 private:
  struct Impl;
  std::unique_ptr<Impl> impl_;
};

} // namespace opencog
