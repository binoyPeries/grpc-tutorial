import ballerina/grpc;

listener grpc:Listener ep = new (9090);

Pet[] petList = [];

@grpc:Descriptor {value: PETSTORE_DESC}
service "PetStore" on ep {

    remote function getPet(GetPetRequest value) returns error|Pet {
        foreach Pet pet in petList {
            if (pet.id == value.id) {
                return pet;
            }
        }
        return error("Pet not found");
    }
    remote function AddPet(CreatePetRequest value) returns Pet|error {
        Pet pet = {id: petList.length() + 1, name: value.name, breed: value.breed, age: value.age};
        petList.push(pet);
        return pet;
    }
}

