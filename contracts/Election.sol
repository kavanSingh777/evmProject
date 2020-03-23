pragma solidity >=0.5.16 <0.7.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    /*trigger an event whenever a vote is cast.
    This will allow us to update our client-side
    application when an account has voted.
    */

    event votedEvent (
        uint indexed _candidateId
    );


    // Read/write candidates
    mapping(uint => Candidate) public candidates;

     // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates Count
    uint public candidatesCount;

    constructor() public
    {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    //Storage:storage key forces the newly created variable to point
    //to the state variable (items) and not a copy. Any changes made to the new variable
    //will directly change the structure of the contract state variable.


    //Memory:The memory option functions as a copy as opposed to a pointer.
    //Thus, using the memory key and making mutations on the
    //newly created variable WILL NOT affect the original state variable.
    function addCandidate (string memory _name) private
    {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
     /*
    1. It accepts one argument. This is an unsigned integer with the candidate's id.
    2. Its visibility is public because we want an external account to call it.
    3. It adds the account that voted to the voters mapping that we just created.
        This will allow us to keep track that the voter has voted in the election.
        We access the account that's calling this function with the global variable "msg.sender" provided by Solidity.
    4. It implements require statements that will stop execution if the conditions are not met.
    First require that the voter hasn't voted before. We do this by reading the account address with "msg.sender" from the mapping.
    If it's there, the account has already voted. Next, it requires that the candidate id is valid.
    The candidate id must be greater than zero and less than or equal to the total candidate count.
    */


    // function vote (uint _candidateId) public {
    //     // require that they haven't voted before
    //     require(!voters[msg.sender]);

    //     // require a valid candidate
    //     require(_candidateId > 0 && _candidateId <= candidatesCount);

    //     // record that voter has voted
    //     voters[msg.sender] = true;

    //     // update candidate vote Count
    //     candidates[_candidateId].voteCount ++;
    // }



    function vote (uint _candidateId) public
    {
    // require that they haven't voted before
    require(!voters[msg.sender]);

    // require a valid candidate
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    // record that voter has voted
    voters[msg.sender] = true;

    // update candidate vote Count
    candidates[_candidateId].voteCount ++;

    // trigger voted event(use emit statements to trigger an event)
    emit votedEvent(_candidateId);
}

}