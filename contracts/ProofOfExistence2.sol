// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ProofOfExistence2 {
  bytes32[] private proofs;

  function storeProofs(bytes32 proof) public {
    proofs.push(proof);
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
    for(uint i = 0; i < proofs.length; i++){
      if(proofs[i] == proof) {
        return true;
      }
    }
    return false;
  }
}
