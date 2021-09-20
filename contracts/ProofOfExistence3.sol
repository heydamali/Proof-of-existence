// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ProofOfExistence3 {
  mapping (bytes32 => bool) private proofs;

  function storeProofs(bytes32 proof) public {
    proofs[proof] = true;
  }
  
  function notarize(string calldata document) external {
    bytes32 proof = proofFor(document);
    storeProofs(proof);
  }

  function proofFor(string memory document) pure public returns (bytes32) {
    return sha256(abi.encodePacked(document));
  }

  function checkDocument(string memory document) view public returns (bool) {
    bytes32 proof = proofFor(document);
    return hasProof(proof);
  }

  function hasProof(bytes32 proof) internal view returns (bool) {
      if(proofs[proof]) {
        return true;
      }

      return false;
  }
}
