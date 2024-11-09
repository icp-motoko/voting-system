import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
    // Candidates with their vote counts
    private let candidates = [
        "1. John Doe",
        "2. Jane Smith",
        "3. Bob Johnson",
        "4. Alice Brown",
        "5. Mike Wilson"
    ];
    
    private var voteCount = Array.init<Nat>(5, 0); // Initialize all vote counts to 0

    // Display all candidates
    public query func displayCandidates() : async Text {
        var display = "\n=== CANDIDATE LIST ===\n";
        for (candidate in candidates.vals()) {
            display #= candidate # "\n";
        };
        display #= "===================";
        return display;
    };

    // Vote for a candidate (1-5)
    public func vote(candidateNum: Nat) : async Text {
        // Adjust for 0-based array index
        let index = candidateNum - 1;
        
        if (candidateNum < 1 or candidateNum > 5) {
            return "Please enter a valid candidate number (1-5)";
        };

        voteCount[index] += 1;
        return "Vote recorded for " # candidates[index];
    };

    // Display current vote counts
    public query func displayVoteCounts() : async Text {
        var display = "\n=== CURRENT VOTE COUNT ===\n";
        for (i in voteCount.keys()) {
            display #= candidates[i] # ": " # 
                      Nat.toText(voteCount[i]) # " votes\n";
        };
        display #= "========================";
        return display;
    };

    // Get votes for a specific candidate
    public query func getVotes(candidateNum: Nat) : async Text {
        if (candidateNum < 1 or candidateNum > 5) {
            return "Please enter a valid candidate number (1-5)";
        };
        
        let index = candidateNum - 1;
        return candidates[index] # " has " # 
               Nat.toText(voteCount[index]) # " votes";
    };
}
