import XCTest
import Foundation
@testable import SwiftDataStructures

class TrieTests: XCTestCase {
  
  func testDebugString() {
    
    let expectation = "123, 345, 234"
    
    let reality = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]]).debugDescription
    
    let realitySort = reality.characters.split{ $0 == " " }.map(String.init).map{
      $0.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " ,"))
      }.sort()
    
    let expectationSort = expectation.characters.split{ $0 == " " }.map(String.init).map{
      $0.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " ,"))
      }.sort()
    
    XCTAssert(expectationSort == realitySort)
    
  }
  
  func testEquatable() {
    
    let first  = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    let second = Trie([[3, 4, 5], [2, 3, 4], [1, 2, 3]])
    
    XCTAssert(first == second)
    
  }
  
  func testInsert() {
    
    let expectation = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    
    var reality = Trie([[3, 4, 5], [2, 3, 4]])
    
    reality.insert([1, 2, 3])
    
    XCTAssert(expectation == reality)
    
  }
  
  func testCompletions() {
    
    let trie = Trie([[1, 2, 3], [1, 2, 3, 4], [1, 2, 5, 6], [3, 4, 5]])
    
    let expectation = [[3], [3, 4], [5, 6]].sort { $0.last < $1.last }
    
    let reality = trie.completions([1, 2]).sort { $0.last < $1.last }
    
    XCTAssert(expectation == reality)
    
  }
  
  func testRemove() {
    
    let expectation = Trie([[3, 4, 5], [2, 3, 4]])
    
    var reality = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    
    XCTAssert(reality.remove([1, 2, 3])?.elementsEqual([1, 2, 3]) == true)
    
    XCTAssert(reality.remove([3, 4, 5, 6]) == nil)
    
    XCTAssert(reality.remove([4, 2, 1]) == nil)
    
    XCTAssert(expectation == reality)
    
  }
  
  func testContains() {
    
    let trie = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    
    XCTAssert(trie.contains([1, 2, 3]))
    XCTAssert(!trie.contains([2, 2, 3]))
    
  }
  
  func testExclusiveOr() {
    
    let frst = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    let scnd = Trie([[1, 2, 3], [3, 4, 6], [2, 3, 4]])
    
    let expectation = Trie([[3, 4, 5], [3, 4, 6]])

    XCTAssert(frst.exclusiveOr(scnd) == expectation)
  }
  
  func testIntersect() {
    let frst = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    let scnd = Trie([[1, 2, 3], [3, 4, 6], [2, 3, 4]])
    
    let expectation = Trie([[1, 2, 3], [2, 3, 4]])
    
    XCTAssert(frst.intersect(scnd) == expectation)
  }
  
  func testIsDisjointWith() {
    
    let frst = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    let disJoint = Trie([[24, 5, 2], [2, 5, 6], [1, 3, 5]])
    let notDisJoint = Trie([[24, 5, 2], [2, 5, 6], [1, 2, 3]])
    
    XCTAssert(frst.isDisjointWith(disJoint))
    
    XCTAssert(!frst.isDisjointWith(notDisJoint))
    
  }
  
  func testIsSupersetOf() {
    
    let under = Trie([[1, 2, 3], [3, 4, 5]])
    
    let isSuper = Trie([[1, 2, 3], [3, 4, 5], [4, 5, 6]])
    let isNotSuper = Trie([[1, 2, 3], [4, 5, 6]])
    
    XCTAssert(isSuper.isSupersetOf(under))
    XCTAssert(!isNotSuper.isSupersetOf(under))
    
  }
  
  func testIsSubsetOf() {
    
    let over = Trie([[1, 2, 3], [3, 4, 5]])
    
    XCTAssert(over.isSubsetOf([[1, 2, 3], [3, 4, 5], [4, 5, 6]]))
    XCTAssert(!over.isSubsetOf([[1, 4, 3], [3, 4, 5], [4, 5, 6]]))
    
  }
  
  func testUnion() {
    
    let frst = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]])
    let scnd = Trie([[1, 2, 3], [3, 4, 6], [2, 3, 4]])
    
    let expectation = Trie([[1, 2, 3], [2, 3, 4], [3, 4, 5], [3, 4, 6]])
    
    XCTAssert(frst.union(scnd) == expectation)
    
  }
  
  func testSubtract() {
    
    let expectation = Trie([[1, 2, 3], [3, 4, 5]])
    
    let reality = Trie([[1, 2, 3], [2, 3, 4], [3, 4, 5], [3, 4, 6]]).subtract([[2, 3, 4], [3, 4, 6]])
    
    XCTAssert(expectation == reality)
    
  }
  
  func testMap() {
    
    let expectation = Trie([[2, 4, 6], [6, 8, 10], [4, 6, 8]])
    let reality = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]]).map { $0.map { $0 * 2 } }
    
    XCTAssert(expectation == reality)
    
  }
  
  func testFlatMap() {
    
    let expectation = Trie([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    
    let reality = Trie([[1, 2, 3], [2, 3, 4]]).flatMap {
      seq in Trie([0, 1].map { num in seq.map { $0 + num } })
    }
    
    XCTAssert(expectation == reality)
    
  }
  
  let isOdd: Int -> Bool = { $0 % 2 == 1 }

  func testFlatMapOpt() {
    
    let expectation = Trie([[2, 4, 6], [6, 8, 10]])
    
    let reality = Trie([[1, 2, 3], [3, 4, 5], [2, 3, 4]]).flatMap {
      $0.first.map(isOdd) == true ? $0.map { $0 * 2 } : nil
    }
    
    XCTAssert(expectation == reality)
    
  }
  
  func testFilter() {
    
    let expectation = Trie([[1, 2, 3], [3, 4, 5]])
    
    let reality = Trie([[1, 2, 3], [2, 3, 4], [3, 4, 5]]).filter {
      $0.first.map(isOdd) == true
    }
    
    XCTAssert(expectation == reality)
    
  }
  
  func testCount() {
    
    let expectation = 3
    
    let reality = Trie([[1, 2, 3], [2, 3, 4], [3, 4, 5]]).count
    
    XCTAssert(expectation == reality)
    
  }
  
  func testSeqType() {
    
    let seqs = (1...10).map { n in (0..<n).map { _ in Int(arc4random_uniform(1000)) } }
    
    let expectation = Set(seqs.map { $0.debugDescription })
    
    let reality = Set(Trie(seqs).map { $0.debugDescription })
    
    XCTAssert(expectation == reality)
    
  }
  
  
}