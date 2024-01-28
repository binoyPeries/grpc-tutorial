import ballerina/io;

PetStoreClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    CreatePetRequest addPetRequest = {name: "ballerina", 'type: "ballerina", breed: "ballerina", age: 1};
    Pet addPetResponse = check ep->AddPet(addPetRequest);
    io:println(addPetResponse);

    GetPetRequest getPetRequest = {id: 1};
    Pet getPetResponse = check ep->getPet(getPetRequest);
    io:println(getPetResponse);
}

